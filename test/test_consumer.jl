
@testset "smoke test" begin
    broker = "localhost:9092"
    topic = "quickstart-events"

    c = KafkaConsumer(broker, "my-consumer-group")

    parlist = [(topic, 0)]
    subscribe(c, parlist)
    timeout_ms = 1000
    msg = nothing
    for i = 1:3
        while msg === nothing
            msg = poll(String, String, c, timeout_ms)
        end
        @show(msg)
        @test msg.topic.topic == topic
        msg = nothing
    end
end
