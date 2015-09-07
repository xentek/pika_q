# encoding: utf-8

module PikaQ
  module Consumers
    class Base
      class << self
        attr_reader :consumer, :consumer_tag, :exchange, :routing_key, :queue
      end

      def self.config(options = {})
        options ||= {} if options.nil?
        options = default_config.merge(options)
        @consumer_tag = options.fetch(:consumer_tag)
        @exchange = options.fetch(:exchange)
        @routing_key = options.fetch(:routing_key)
        @queue = options.fetch(:queue)
      end

      def self.start(channel, &block)
        @exchange = exchange.establish(channel) if exchange.respond_to? :establish
        @queue = queue.create(channel) if queue.respond_to? :create

        unless exchange.predeclared?
          queue.bind(exchange, { routing_key: routing_key })
        end

        @consumer = queue.subscribe(manual_ack: true,
                                  block: true,
                                  consumer_tag: consumer_tag,
                                  &Proc.new)
        consumer
      rescue Interrupt
        consumer.cancel
        consumer.channel.close
      end

      private

      def self.default_consumer_tag(unique_id = SecureRandom.uuid)
        "#{self.to_s.gsub('::','.')}.#{ENV['RACK_ENV']}.#{unique_id}".downcase
      end

      def self.default_config
        {
          consumer_tag: default_consumer_tag,
          exchange: PikaQ::Exchanges::Default,
          routing_key: nil,
          queue: ''
        }.freeze
      end
    end
  end
end
