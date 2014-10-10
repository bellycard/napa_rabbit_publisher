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
      data = respond_to?(:amqp_properties) ? amqp_properties : self
      routing_key = "#{self.class.name.underscore}_#{key}"
      NapaRabbitPublisher.publish(data, routing_key)
    end
  end
end
