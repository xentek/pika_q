# encoding: utf-8

ENV['RUBY_ENV'] = 'test'
ENV['RABBITMQ_URL'] ||= 'amqp://guest:guest@127.0.0.1:5672'
lib_path = File.expand_path('../../lib', __FILE__)
($:.unshift lib_path) unless ($:.include? lib_path)
Bundler.require(:default, ENV['RACK_ENV'])
require 'minitest-spec-context'
require 'minitest/autorun'
MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new
