# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 8'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use falcon as webserver
gem 'falcon'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.13'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 5.4'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.19'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'devise'
gem 'faker'
gem 'ffaker'
gem 'grape'
gem 'grape-swagger'
gem 'grape-swagger-entity'
gem 'grape-swagger-rails'
gem 'grape-swagger-representable'
gem 'paper_trail'

gem 'faraday-retry'

gem 'ar-uuid'
gem 'ulid-rails', git: 'https://github.com/davidsiaw/ulid-rails'

gem 'sidekiq'
gem 'sidekiq-scheduler'

gem 'async-io'
gem 'async-redis'
gem 'async-websocket'
gem 'thread-local'

group :development, :test do
  gem 'async-rspec'
  gem 'factory_bot_rails'
  gem 'pry-byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'falcon-capybara'
  gem 'rspec_junit_formatter'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'webdrivers'
end

group :bundleraudit, :development do
  gem 'bundler-audit'
end

group :brakeman, :development do
  gem 'brakeman'
end

group :danger, :development do
  gem 'danger'
end

group :rubocop, :development do
  gem 'rubocop'
  gem 'rubocop-capybara'
  gem 'rubocop-factory_bot'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'rubocop-rspec_rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.10'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.1.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
