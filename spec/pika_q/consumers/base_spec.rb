# encoding: utf-8

require 'spec_helper'

describe PikaQ::Consumers::Base do
  let(:uuid) { '2d931510-d99f-494a-8c67-87feb05e1594' }
  let(:routing_key) { 'test.routing.key' }
  before do
    class TestConsumer < PikaQ::Consumers::Base
      config queue: PikaQ::Queues::Default,
             exchange: PikaQ::Exchanges::Default,
             consumer_tag: default_consumer_tag(uuid),
             routing_key: 'test.routing.key'
    end
  end

  it 'has a queue' do
    TestConsumer.queue.must_equal PikaQ::Queues::Default
  end

  it 'has an exchange' do
    TestConsumer.exchange.must_equal PikaQ::Exchanges::Default
  end

  it 'has a consumer tag' do
    TestConsumer.consumer_tag.must_equal "testworker.test.#{uuid}"
  end

  it 'has a routing key' do
    TestConsumer.routing_key.must_equal routing_key
  end
end
