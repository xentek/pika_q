# encoding: utf-8

require 'bunny'

module PikaQ
  class Publisher
    attr_reader :channel, :exchange, :exchange_name, :exchange_type, :exchange_options

    def initialize(channel, exchange_name, exchange_type = :default, exchange_options = { durable: false, auto_delete: false })
      @channel = channel
      @exchange_name = exchange_name
      @exchange_type = exchange_type
      @exchange_options = exchange_options
      @exchange = connect_to_exchange
    end

    def send_message(payload, message_options = {})
      message_options ||= {}
      message_options = default_message_options.merge(message_options)
      published = exchange.publish(payload, message_options)
      channel.close
      published
    end

    private

    def default_message_options
      {
        content_type: 'application/json',
        message_id: SecureRandom.uuid,
        persistent: false,
        routing_key: nil,
        timestamp: DateTime.now.to_time.to_i
      }
    end

    def connect_to_exchange
      if exchange_type == :default
        channel.default_exchange
      else
        ::Bunny::Exchange.new(channel, exchange_type, exchange_name, exchange_options)
      end
    end
  end
end
