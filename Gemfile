# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'pg'
gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.1'
gem 'sass-rails', '>= 6'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'hotwire-rails'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'devise'
gem 'devise_lastseenable'

gem 'mailgun-ruby'

gem 'asset_sync'
gem 'aws-sdk-s3'
gem 'fog-aws'

# Use Active Storage variant
gem 'image_processing'

gem 'friendly_id', '~> 5.4.0'

gem 'active_link_to'

gem 'acts_as_commentable'
gem 'acts_as_follower', github: 'tcocca/acts_as_follower', branch: 'master'
gem 'acts_as_votable'

gem 'goldiloader'

gem 'merit'

gem 'email_validator'

gem 'counter_culture'
gem 'discard'
gem 'public_activity'

gem 'kaminari'

# For import
gem 'dalli'
gem 'nokogiri'
gem 'typhoeus'

gem 'rolify'

gem 'searchkick'

gem 'skylight', '5.0.0.beta4'

gem 'acts-as-taggable-on', '~> 7.0'

gem 'pghero'
gem 'pg_query', '>= 0.9.0'

gem 'sidekiq', '~> 6.1.3'

group :production do
  gem 'tunemygc'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '~> 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'guard-livereload', '~> 2.5', require: false
  gem 'rack-livereload'

  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'letter_opener'

  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

gem 'tailwindcss-rails', '~> 0.3.1'
gem 'trix-rails', require: 'trix'
