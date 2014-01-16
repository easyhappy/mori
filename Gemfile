eval(File.read(File.dirname(__FILE__) + '/Gemfile.local'), binding) rescue source 'http://rubygems.org'
#source 'http://ruby.taobao.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use mysql as the database for Active Record
gem 'mysql2'
gem 'mongo'
gem 'mongoid', github: 'mongoid/mongoid'
gem 'bson_ext'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'


# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder',     '~> 1.2'

gem 'slim-rails',   '2.0.3'
gem 'will_paginate','3.0.4'
gem 'showbuilder',  '0.0.15'
gem 'coffee-rails', '~> 4.0.0'
gem 'activerecord-session_store', github: 'rails/activerecord-session_store'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'pry',                    '0.9.12'
  gem 'pry-nav',                '0.2.2'
  gem 'pry-stack_explorer',     '0.4.9'
  gem 'pry-rails',              '0.2.2'
  gem 'zeus',                   '0.13.3'
  gem 'thin',                   '1.6.1'
  gem 'guard-rspec',            '4.2.4',  require: false
end

gem 'typhoeus',                 '0.6.6'
gem 'nokogiri',                 '1.6.0'
gem 'cancan',                   '1.6.10'
gem 'rails_admin',              '0.6.0'
gem 'kaminari'
gem 'unicorn-rails'

#yaml配置信息
gem 'settingslogic',            '2.0.9'

gem 'hpricot'
gem 'kaminari'
gem 'quiet_assets'
gem 'activerecord-import'

gem 'devise'
gem 'omniauth'

gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-github'

gem "omniauth-google-oauth2"
gem 'newrelic_rpm'

group :test do
  gem 'spork'
  gem 'spork-rails'
  gem 'rspec-rails'
  gem 'factory_girl_rails', '4.2.1'
end
