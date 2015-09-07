# encoding: utf-8

require 'spec_helper'

describe PikaQ::Exchanges::Base do
  it 'can establish the default exchange' do
    PikaQ::Exchanges::Base.establish(PikaQ::Connection.new.channel).must_be_kind_of ::Bunny::Exchange
  end

  it 'can generate the exchange name' do
    PikaQ::Exchanges::Base.generated_exchange_name.must_equal 'pikaq.exchanges.base.test'
  end
end
