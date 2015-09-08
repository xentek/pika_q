# pika_q
[![Build Status](https://travis-ci.org/xentek/pika_q.svg)](https://travis-ci.org/xentek/pika_q)

---

![PikaQ, I choose you!](http://xentek-images.s3.amazonaws.com/pikachu-and-ash.png "PikaQ, I choose you!")

#### __PikaQ, I choose YOU!__

PikaQ makes working with Rabbit MQ _even_ easier. It provides a thin layer around [Bunny](http://rubybunny.info), the defacto standard ruby library for Rabbit MQ. It provides objects for writing your own high performance, message consumers, as well a generic service object for publishing messages to any Rabbit MQ exchange.

> The name "pika" is used for any member of the Ochotonidae, a family within the order of lagomorphs, which also includes the Leporidae (rabbits and hares).
> __-- [Wikipedia](https://en.wikipedia.org/wiki/Pika)__

---

### Gemfile

    gem 'pika_q'

## Require

    require 'pika_q'

## Usage

### Creating a connection

```ruby
connection = PikaQ::Connection.new
channel = connection.channel
```

By default, it uses the value of `ENV['RABBITMQ_URL']` as the connection string, which if `nil`, will fallback to Bunny's default connection string (i.e. `ampq://guest:guest@localhost:5672'`). You can also supply a connection string when initalizing `PikaQ::Connection`.

### Publishing a message

This sends a message to the default exchange:

```ruby
channel = PikaQ::Connection.new.channel
publisher = PikaQ::Publisher.new(channel, '', :default)

# publish a message to the exchange
publisher.send_message('{"test":"ok"}')
```

`PikaQ::Publisher.new` takes the same arguments as [`Bunny::Exchange.new`](http://reference.rubybunny.info/Bunny/Exchange.html#initialize-instance_method).

### Establishing an Exchange

Establish the default exchange:

```ruby
channel = PikaQ::Connection.new.channel
exchange = PikaQ::Exchanges::Default.establish(channel)
```

__The default exchange is special and can't be removed -- it's built into the Rabbit MQ server.__

To establish other types of exchanges, you need to create an object that responds to `establish` and takes a `channel` as an argument. The easiest way to do this is to subclass `PikaQ::Exchanges::Base` and overwrite the `establish` method.

`PikaQ::Exchanges::Base.establish` provides a default implementation that returns a `:direct` exchange. The name is created automatically by `PikaQ::Exchanges::Base.generated_exchange_name`, which will return a string based on the name of your class and the value of `ENV['RUBY_ENV']`, e.g. `pikaq.exchanges.base.development`.

### Creating a Queue

```ruby
channel = PikaQ::Connection.new.channel
queue = PikaQ::Queues::Base.create(channel, { durable: false, auto_delete: false, exclusive: false })
```

Your consumer will bind your queues to exhcnages. Create subclasses only for the sake of identity (helpful if the queue throws an exception). `PikaQ::Queues::Base.create` is a factory method that returns an instance of `Bunny::Queue`. Like exchanges, the `PikaQ::Queues::Base.generated_queue_name` method will generate a queue name for you based on the name of your subclass, e.g. `pikaq.queues.base.development`.

### Creating a Consumer

Create and configure a consumer subclass:

```ruby
class MyConsumer < PikaQ::Consumers::Base
      config queue:       PikaQ::Queues::Default,
             exchange:     PikaQ::Exchanges::Default,
             consumer_tag: default_consumer_tag('abcd-1234-efgh-5678'),
             routing_key:  'test.routing.key'
end
```

Pass the name of your `queue` and `exchange` clases. You can use any string for the optional `consumer_tag`, but it must be unique. It's recommended to use the `default_consumer_tag` method, which will generate a new UUID for you if you don't supply an argument. The routing key is also optional, and only required by some types of exchanges.

Now you're ready to make it do some actual work when it recieves a message. I prefer to create an executable shellscript for these but you can run them however you like. Just know that a consumer is a essentially a daemon and will keep running until it's stopped. Use `foreman` to manaage these and export them to upstart, etc for use in production.

```ruby
#!/usr/bin/env ruby

require 'pika/mq'
require 'my_consumer'
channel = PikaQ::Connection.new.channel
channel.prefetch(20) # this will affect your throughput, so expiriment with what's right for your environment.
Log = Logger.new(STDOUT)

MyConsumer.start do |delivery_info, properties, payload|
  Log.info(delivery_info)
  Log.info(properties)
  Log.info(payload)
end

channel.close # this will run when the consumer is stopped
```

---

## Contributing

Bug reports and pull requests are welcome on GitHub at [xentek/pika_q](https://github.com/xentek/pika_q). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
