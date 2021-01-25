source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'pg'

gem 'webpacker', '~> 5.2.1'
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false


gem 'devise'
gem 'devise_lastseenable'

gem 'mailgun-ruby'

gem 'fog-aws'
gem 'asset_sync'
gem 'aws-sdk-s3'


gem 'image_processing'

gem 'friendly_id', '~> 5.4.0'

gem 'active_link_to'

gem 'acts_as_commentable'
gem 'acts_as_votable'
gem 'acts_as_follower', github: 'tcocca/acts_as_follower', branch: 'master'

gem 'goldiloader'

gem 'merit'

gem 'email_validator'

# gem 'counter_culture', '~> 2.0'

gem 'kaminari'

# For import
gem 'nokogiri'
gem 'typhoeus'
gem 'dalli'

gem 'wicked'
gem 'rolify'

gem 'searchkick'

gem 'skylight', '5.0.0.beta4'

group :production do
  gem 'tunemygc'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'guard-livereload', '~> 2.5', require: false
  gem 'rack-livereload'

  gem "better_errors"
  gem "binding_of_caller"

  gem "bullet"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
