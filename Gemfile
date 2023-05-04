# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.7.7'

gem 'rails', '~> 4.2.5'

gem 'aws-sdk', '< 2.0'
gem 'bigdecimal', '1.4.4'
gem 'country_select'
gem 'dalli'
gem 'devise'
gem 'haml-rails'
gem 'jquery-rails', '~> 4.4.0'
gem 'kramdown'
gem 'mail_form'
gem 'newrelic_rpm'
gem 'paperclip', '< 5.0'
gem 'pg', '< 1.0'
gem 'rails_admin', '~> 0.6.6'
gem 'sitemap_generator'
gem 'twitter'
gem 'twitter-bootstrap-rails'
gem 'unicorn'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
end

gem 'rails_12factor', group: :production
