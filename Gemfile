source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

gem 'rails', '~> 7.0.4'
gem 'sprockets-rails'
gem 'puma', '~> 5.0'
gem 'jsbundling-rails'
gem 'cssbundling-rails'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bootsnap', require: false
gem 'kaminari', '~> 1.2'
gem 'bcrypt'
gem 'draper'
gem 'valid_email2'
gem 'pagy'
gem 'rubyzip'
gem 'caxlsx'
gem 'caxlsx_rails'
gem 'rubyXL'
gem 'activerecord-import'
gem 'gravtastic'
gem 'blueprinter'
gem 'pundit', '~> 2.1'
gem 'letsrate'
gem 'carrierwave'
gem 'responders'
gem 'active_model_serializers'
gem 'doorkeeper'
gem 'dotenv-rails'
gem 'with_model'
gem 'excon'
gem 'acts_as_votable'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'font-awesome-rails'
gem 'httparty'
gem 'rqrcode'
gem 'rqrcode_png'
gem 'sidekiq'
gem 'redis'
gem 'faker', '~> 2'
gem "hotwire-rails", "~> 0.1.3"

group :development, :test do
  gem 'debug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem 'rubocop'
  gem 'rspec-rails'
  gem 'factory_bot'
  gem 'shoulda-matchers'
  gem 'rails-controller-testing'
end

group :production do
  gem 'pg'
end

group :development do
  gem 'web-console'
  gem 'letter_opener'
  gem 'letter_opener_web'
end

gem "dockerfile-rails", ">= 1.0.0", :group => :development
