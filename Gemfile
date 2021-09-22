source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# ruby '2.5.1'

gem 'rails', '~> 6.0', '>= 6.0.3.4'

# Basic
gem 'active_record_query_trace'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'colorize'
gem 'inky-rb', require: 'inky'
gem 'sass-rails'
gem 'premailer-rails'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'

# Auth
gem 'devise_token_auth', '~> 1.1.4'

# CORS
gem 'rack-cors', '~> 1.1.1'

# Redering
gem 'jbuilder', '~> 2.10.1'


group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'better_errors'
  gem 'pry-byebug'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'shoulda-matchers', '~> 4.0'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
