# encoding: utf-8

module PikaQ
  module Exchanges
    class Base < Bunny::Exchange
      def self.establish(channel)
        new(channel, :direct, generated_exchange_name, auto_delete: false, durable: false)
      end

      def self.generated_exchange_name
        "#{self.to_s.gsub('::','.')}.#{ENV['RUBY_ENV']}".downcase
      end
    end
  end
end
