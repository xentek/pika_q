# encoding: utf-8

require 'spec_helper'

describe PikaQ::Connection do
  let(:connection) { PikaQ::Connection.new }

  it 'has a session' do
    connection.session.must_be_kind_of Bunny::Session
  end

  it 'has a channel' do
    connection.channel.must_be_kind_of Bunny::Channel
  end
end
