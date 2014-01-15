source 'https://rubygems.org'

gem 'rails'
gem 'dropbox-sdk'

# Assets
gem 'less-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'therubyracer'

# Views
gem 'haml-rails'
gem 'jbuilder'

group :development do
  gem 'sqlite3'
  gem 'byebug'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rspec-kickstarter'
end

group :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.99.beta1'
  gem 'capybara'
  gem 'turnip'
end

group :staging, :production do
  gem 'pg'
  gem 'unicorn'
  gem 'execjs'
end
