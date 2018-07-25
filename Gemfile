source 'https://rubygems.org'

gem 'rails', '3.2.22'
gem 'bootstrap-sass', "~> 2.0.0"

gem 'pg'
gem 'httparty'
gem 'hashie'

# Workaround for no longer supported rails issue: 
# https://github.com/rails/rails/issues/9256
gem 'test-unit', '~> 3.0'

gem "friendly_id", "~> 4.0.1"

gem "gibbon"#, "~> 0.4.6"
gem "simple_form"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass', '~> 3.1.10'
  gem 'sass-rails',   '~> 3.2.6'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.0.3'
  gem 'turbo-sprockets-rails3'
end

gem 'jquery-rails'

# TODO: Working tests will return!
group :test, :development do
  gem 'byebug'
  #gem 'rspec-rails', '2.8.1'
  #gem 'capybara', '1.1.2'
  #gem 'guard-rspec'
  #gem 'guard-spork'
  #gem 'factory_girl_rails', "~> 3.0"
  #gem 'delorean'
  #gem 'vcr'
  #gem 'fakeweb'
  #gem 'spring'
  #gem 'spring-commands-rspec'
end

# group :development do
#   gem 'capistrano'
#   gem 'capistrano-rails'
#   gem 'capistrano-bundler'
#   gem 'capistrano-systemd-multiservice'
#   gem 'aws-sdk'
#   gem 'capistrano-measure'
#   gem 'capistrano-asg'
#   #gem 'capistrano-puma'
#   gem 'capistrano3-puma', github: "seuros/capistrano-puma"
# end


# Use unicorn as the app server
gem 'unicorn'
#gem 'puma', '~> 3.7'

# Deploy with Capistrano
group :development do
  gem 'capistrano'
  gem 'capistrano-rbenv'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano3-unicorn'
  #gem 'capistrano3-puma', github: "seuros/capistrano-puma"
end

gem 'mailchimp-api', require: 'mailchimp'

# Legacy Content Managment to be removed
# gem 'refinerycms'
# gem 'refinerycms-blog'
# gem 'refinerycms-justices', :path => 'vendor/extensions'
# gem 'refinerycms-executives', :path => 'vendor/extensions'
