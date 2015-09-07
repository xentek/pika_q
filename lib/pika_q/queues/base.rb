# encoding: utf-8

module PikaQ
  module Queues
    class Base < Bunny::Queue
      def self.create(channel, options = { durable: false, auto_delete: false, exclusive: false })
        new(channel, generated_queue_name, options)
      end

      def self.generated_queue_name
        "#{self.to_s.gsub('::','.')}.#{ENV['RUBY_ENV']}".downcase
      end
    end
  end
end
