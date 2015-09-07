# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pika_q/version'

Gem::Specification.new do |gem|
  gem.name          = "pika_q"
  gem.version       = PikaQ::VERSION
  gem.authors       = ["Eric Marden"]
  gem.email         = ["eric.marden@gmail.com"]
  gem.summary       = %q{PikaQ makes working with Rabbit MQ easier.}
  gem.description   = %q{PikaQ makes working with Rabbit MQ easier.  It provides a thin layer around Bunny, the defacto standard ruby library for Rabbit MQ.}
  gem.homepage      = "http://github.com/xentek/pika_q"
  gem.license       = "MIT"

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'bunny'
end
