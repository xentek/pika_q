require 'rake'
require 'rake/testtask'
require 'bundler/gem_tasks'

# environment
ENV['RACK_ENV'] ||= 'development'
ENV['RABBITMQ_URL'] = 'amqp://guest:guest@127.0.0.1:5672'

# load path
lib_path = File.expand_path('../lib', __FILE__)
($:.unshift lib_path) unless ($:.include? lib_path)

Rake::TestTask.new do |t|
  t.libs << "spec"
  t.pattern = "spec/**/*_spec.rb"
end

# tasks
task :default => [:test]
