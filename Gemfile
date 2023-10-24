source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.7", ">= 7.0.7.2"

# The original asset pipeline for Rails
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps
gem "importmap-rails"

# Hotwire's SPA-like page accelerator
gem "turbo-rails"

# Hotwire's modest JavaScript framework
gem "stimulus-rails"

# Use Tailwind CSS
gem "tailwindcss-rails"

# Build JSON APIs with ease
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

gem "image_processing", "~> 1.2"


#User Authentication
gem 'devise'

gem 'sidekiq', "~> 7.1.2"
gem 'sidekiq-cron'

gem "capybara"
gem "nokogiri"
gem "selenium-webdriver"
gem "webdrivers", "= 5.3.0"
# Use the will_paginate gem for pagination functionality
gem 'will_paginate', '~> 4.0'
# Use the friendly_id gem for creating slugs and improving
gem 'friendly_id', '~> 5.4.0'

gem 'reverse_markdown'
gem 'kramdown'
gem "rolify"
gem 'pg_search'

group :development, :test do
  gem "byebug"
  gem "pry-rails"
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"

end

group :development do
  gem "web-console"
  gem "rails_live_reload"
end
