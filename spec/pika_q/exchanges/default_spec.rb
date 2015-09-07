# encoding: utf-8

require 'spec_helper'

describe PikaQ::Exchanges::Default do
  it 'can establish the default exchange' do
    PikaQ::Exchanges::Default.establish(PikaQ::Connection.new.channel).must_be_kind_of ::Bunny::Exchange
  end
end
