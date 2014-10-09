module NapaRabbitPublisher
  require 'bunny'
  require 'napa_rabbit_publisher/version'
  require 'napa_rabbit_publisher/amqp_singleton'
  require 'napa_rabbit_publisher/rabbit_active_record_callbacks'

  def self.publish(data, routing_key)
    amqp = NapaRabbitPublisher::AMQPSingleton.instance
    amqp.exchange.publish(data.to_json, routing_key: routing_key, content_type: 'application/json')
  end
end
