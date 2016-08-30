require 'singleton'
module NapaRabbitPublisher
  class AMQPSingleton
    include Singleton
    attr_reader :connection, :channel, :exchange
    # we only want one connection at a time (most of the time) to RabbitMQ
    def initialize
      @connection = Bunny.new(ENV['CLOUDAMQP_URL'] || ENV['AMQP_HOST'])
      @connection.start
      @channel = connection.create_channel
      @exchange = channel.topic(ENV['AMQP_EXCHANGE'] || ENV['SERVICE_NAME'])
    end
  end
end
