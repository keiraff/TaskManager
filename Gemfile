# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.3"

gem "active_decorator"
gem "bcrypt"
gem "bootsnap", require: false
gem "city-state"
gem "http"
gem "importmap-rails"
gem "jbuilder"
gem "pagy"
gem "pg", "~> 1.1"
gem "puma"
gem "pundit"
gem "rails", "~> 7.0.6"
gem "ransack"
gem "sassc-rails"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  gem "debug", platforms: [:mri, :mingw, :x64_mingw]
  gem "dotenv-rails"
  gem "factory_bot_rails"
  gem "ffaker"
  gem "strong_migrations"
end

group :development do
  gem "annotate"
  gem "brakeman"
  gem "bundler-audit"
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-rspec"
  gem "web-console"
end

group :test do
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "simplecov"
end
