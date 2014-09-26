source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.6'

# Easy HTTP Requests
gem 'faraday', '~> 0.9.0'

# Consume RSS Feeds
gem 'simple-rss', '~> 1.3.1'

# For help with heroku and timeouts
gem 'rack-timeout', '~> 0.0.4'

# Making it easy to serialize models for client-side use
gem 'active_model_serializers', '~> 0.9.0'

# Flexible authentication solution for Rails with Warden
gem 'devise', '~> 3.3.0'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.1'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '~> 1.1.3'
  gem 'dotenv-rails', '~> 0.11.1'
end

group :production do
  # Use postgresql as the database for Active Record
  gem 'pg', '~> 0.17.1'
  gem 'unicorn', '~> 4.8.3'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.1.0'
  gem 'sqlite3', '~> 1.3.9'
  gem 'thin', '~> 1.6.2'
  gem 'pry-byebug', '~> 2.0.0'
end

group :test do  
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'faker', '~> 1.4.3'
end

