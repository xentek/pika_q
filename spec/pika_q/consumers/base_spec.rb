# encoding: utf-8

require 'spec_helper'

describe PikaQ::Consumers::Base do
  before do
    class TestConsumer < PikaQ::Consumers::Base
      config queue: PikaQ::Queues::Base,
             exchange: PikaQ::Exchanges::Default,
             consumer_tag: default_consumer_tag('2d931510-d99f-494a-8c67-87feb05e1594'),
             routing_key: 'test.routing.key'
    end
  end

  it 'has a queue' do
    TestConsumer.queue.must_equal PikaQ::Queues::Base
  end

  it 'has an exchange' do
    TestConsumer.exchange.must_equal PikaQ::Exchanges::Default
  end

  it 'has a consumer tag' do
    TestConsumer.consumer_tag.must_equal 'testconsumer.test.2d931510-d99f-494a-8c67-87feb05e1594'
  end

  it 'has a routing key' do
    TestConsumer.routing_key.must_equal 'test.routing.key'
  end
end
