module NapaRabbitPublisher
  module RabbitActiveRecordCallbacks
    def self.included(base)
      base.class_eval do
        after_create do
          post_to_rabbit('created')
        end
        after_update do
          post_to_rabbit('updated')
        end
      end
    end

    def post_to_rabbit(key)
      # broadcast to rabbit
      amqp = NapaRabbitPublisher::AMQPSingleton.instance
      data = {}
      begin
        data = "#{self.class.name}Representer".constantize.new(self)
      rescue NameError => e
        data = respond_to?(:amqp_properties) ? amqp_properties : self
      end
      # routing_key = <singular model name>_<past tense action>
      routing_key = "#{self.class.name.underscore}_#{key}"
      amqp.exchange.publish(data.to_json, routing_key: routing_key, content_type: 'application/json')
    end
  end
end
