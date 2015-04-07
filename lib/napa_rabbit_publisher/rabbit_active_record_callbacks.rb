module NapaRabbitPublisher
  module RabbitActiveRecordCallbacks
    def self.included(base)
      base.after_commit :post_create_to_rabbit, on: :create
      base.after_commit :post_update_to_rabbit, on: :update
      base.after_commit :post_destroy_to_rabbit, on: :destroy
    end

    def post_create_to_rabbit
      post_to_rabbit("created")
    end

    def post_update_to_rabbit
      post_to_rabbit("updated")
    end

    def post_destroy_to_rabbit
      post_to_rabbit("destroyed")
    end

    def post_to_rabbit(key)
      data = respond_to?(:amqp_properties) ? amqp_properties : self
      routing_key = "#{self.class.name.underscore}_#{key}"
      NapaRabbitPublisher.publish(data, routing_key)
    end
  end
end
