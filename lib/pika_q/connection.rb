# encoding: utf-8

module PikaQ
  class Connection
    attr_reader :channel, :rabbitmq_url, :session

    def initialize(rabbitmq_url = ENV['RABBITMQ_URL'])
      @session = Bunny.new(rabbitmq)
      @session.start
      @channel = @session.create_channel
    end
  end
end
