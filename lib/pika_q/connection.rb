# encoding: utf-8

module PikaQ
  class Connection
    attr_reader :channel, :rabbitmq_url, :session

    def initialize(rabbitmq_url = ENV['RABBITMQ_URL'], options = { read_timeout: 10, heartbeat: 10 })
      @session = Bunny.new(rabbitmq_url, options)
      @session.start
      @channel = @session.create_channel
    end
  end
end
