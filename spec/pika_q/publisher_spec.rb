# encoding: utf-8

require 'spec_helper'

describe PikaQ::Publisher do
  let(:publisher) { PikaQ::Publisher.new(PikaQ::Connection.new.channel, '', :default) }

  it "has a channel" do
    publisher.channel.must_be_kind_of ::Bunny::Channel
  end

  it "has an exchange name" do
    publisher.exchange_name.must_equal ''
  end

  it "has an exchange type" do
    publisher.exchange_type.must_equal :default
  end

  it "has an exchange" do
    publisher.exchange.must_be_kind_of ::Bunny::Exchange
  end

  it "can publish a message" do
    publisher.send_message('{"test":"ok"}').must_be_kind_of ::Bunny::Exchange
  end
end
