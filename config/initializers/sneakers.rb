require 'sneakers'

# Sneakers.configure(connection: Bunny.new(hostname: "rabbitmq:5672"), durable: true, daemonize: false , prefetch: 1, threads: 1,
#   ack: true)
 Sneakers.configure(connection: Bunny.new(hostname: "rabbitmq:5672"),
                            share_threads: true,
                            heartbeat: 2,
                            exchange: 'sneakers',
                            exchange_type: :direct,
                            timeout_job_after: 60,
                            workers: 2,
                            thread: 10,
                            prefetch: 10,
                            # daemonize:true ,
                            durable: true,
                            exclusive: false
)

Sneakers.logger = Rails.logger
Sneakers.logger.level = Logger::WARN

# sleep 0.5
