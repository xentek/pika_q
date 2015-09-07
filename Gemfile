source 'https://rubygems.org'

gemspec

group :test, :rake do
  gem 'bundler'
end

group :rake do
  gem 'rake'
end

group :test do
  gem 'minitest'
  gem 'minitest-spec-context'
  gem 'minitest-reporters', require: 'minitest/reporters'
end

group :development do
  gem 'gem-release', require: false
end
