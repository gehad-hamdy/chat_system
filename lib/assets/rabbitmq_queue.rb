class RabbitmqQueue
  def self.enqueue(job)
    connection = Bunny.new(hostname: "rabbitmq:5672").start
    connection.create_channel.queue('jobs', durable: true).publish(job.to_json.to_s)
    connection.close
  end
end
