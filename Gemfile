# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.2.0"
gem "rails", "~> 7.1.3", ">= 7.1.3.4"

gem "jbuilder"
gem "pg", "~> 1.1"
gem "propshaft"
gem "puma", ">= 5.0"
gem "redis", ">= 4.0.1"

gem "importmap-rails"
gem "stimulus-rails"
gem "turbo-rails"

gem "tailwindcss-rails"

gem "bootsnap", require: false
gem "tzinfo-data", platforms: %i[windows jruby]

# Authentication
gem "devise"
gem "letter_opener_web"

group :development do
  gem "annotate"
  gem "awesome_print"
  gem "better_errors"
  gem "binding_of_caller"
  gem "brakeman"
  gem "bundler-audit"
  gem "erb_lint", require: false
  gem "hotwire-livereload"
  gem "rubocop"
  gem "web-console"

  # NEOVIM IDE / REMEMBER TO UPDATE MASON
  gem "neovim"
  gem "solargraph"
end

group :test do
  # gem "capybara"
  gem "database_cleaner-active_record"
  # gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "simplecov", require: false
end

group :development, :test do
  gem "bullet"
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"
end
