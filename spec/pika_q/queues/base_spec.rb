# encoding: utf-8

require 'spec_helper'

describe PikaQ::Queues::Base do
  it 'can create the default queue' do
    PikaQ::Queues::Base.new(PikaQ::Connection.new.channel).must_be_kind_of ::Bunny::Queue
  end
  
  it 'can generate a queue name' do
    PikaQ::Queues::Base.new(PikaQ::Connection.new.channel).generated_queue_name.must_equal 'pikaq.queues.base.test'
  end
end
