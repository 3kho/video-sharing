source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.6'

gem 'dotenv-rails', require: 'dotenv/rails-now'
gem 'rails', '~> 6.0.4', '>= 6.0.4.7'
gem 'pg'
gem 'puma', '6.3.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'devise'
gem 'bootstrap'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'faraday'
gem "redis", ">= 3", "< 5"

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate'
  gem 'bullet'
end

group :test, :development do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem "webmock"
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
