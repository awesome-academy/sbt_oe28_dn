source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bcrypt", "3.1.12"
gem "bootstrap-sass", "3.3.7"
gem "cancancan"
gem "carrierwave", "~> 0.10.0"
gem "chartkick", "~> 2.2.0"
gem "ckeditor", "~>4.2.4"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "devise"
gem "faker", git: "https://github.com/faker-ruby/faker.git", branch: "master"
gem "font-awesome-sass", "4.7.0"
gem "friendly_id", "~> 5.2.4"
gem "groupdate"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "jquery-turbolinks"
gem "jquery-ui-rails", "5.0.5"
gem "mini_magick", "~> 4.3"
gem "omniauth-facebook"
gem "paranoia"
gem "puma", "~> 3.0"
gem "rails", "~> 5.0.7", ">= 5.0.7.2"
gem "rails-i18n"
gem "rails-ujs"
gem "rails_admin"
gem "ransack"
gem "sass-rails", "~> 5.0"
gem "social-share-button", "~> 1.1.0"
gem "stringex"
gem "uglifier", ">= 1.3.0"
gem "will_paginate", "3.1.6"

group :development, :test do
  gem "byebug", platform: :mri
  gem "factory_bot_rails"
  gem "rspec-rails"
  gem "rubocop", "~> 0.54.0", require: false
  gem "sqlite3", "1.3.13"
end

group :development do
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", "3.28.0"
  gem "guard", "2.15.0"
  gem "guard-minitest", "2.4.6"
  gem "guard-rspec"
  gem "launchy"
  gem "minitest"
  gem "minitest-reporters", "1.3.8"
  gem "rails-controller-testing", "1.0.4"
  gem "selenium-webdriver", "3.142.4"
  gem "shoulda-matchers", github: "thoughtbot/shoulda-matchers"
  gem "simplecov", require: false
  gem "webdrivers", "4.1.2"
end

group :production do
  gem "pg"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
