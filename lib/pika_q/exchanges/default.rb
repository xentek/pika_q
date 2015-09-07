# encoding: utf-8

module PikaQ
  module Exchanges
    class Default < Base
      def self.establish(channel)
        channel.default_exchange
      end
    end
  end
end
