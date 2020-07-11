source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '5.2.4.3'
gem 'bootsnap', require: false

# Supported DBs
gem 'mysql2'

# Applicaiton server
gem 'puma'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'ffaker'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
