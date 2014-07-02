# NapaRabbitPublisher

This provides an easy to use library with an AMQP Singleton for connecting and sending data to RabbitMQ

## Installation

Add this line to your application's Gemfile:

    gem 'napa_rabbit_publisher'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install napa_rabbit_publisher

## Usage

define the following variables in your ENV
+ AMQP_HOST # ex: amqp://localhost:5672
+ SERVICE_NAME # ex: my-awesome-service

ENV['SERVICE_NAME'] defines the topic exchange that you will be sending messages through.

```
amqp = NapaRabbitPublisher::AMQPSingleton.instance
data = {i: :like_turtles}
routing_key = 'meme_quotes'
amqp.exchange.publish(data.to_json, routing_key: routing_key, content_type: 'application/json')
```

There is also an ActiveRecord module that will broadcast changes to models automatically (using the after_save hook)

```
class User < ActiveRecord::Base
  include NapaRabbitPublisher::RabbitActiveRecordCallbacks
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
