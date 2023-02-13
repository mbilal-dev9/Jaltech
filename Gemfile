source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.3", ">= 7.0.3.1"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 6.1"

gem "rswag-api", "~> 2.5", ">= 2.5.1"
gem "rswag-ui", "~> 2.5", ">= 2.5.1"

gem "active_model_serializers", "~> 0.10.13"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"
gem "devise_token_auth", github: "lynndylanhurley/devise_token_auth", ref: "8f44a8c66fd772b2d33be4ba187c0b1a47caba2a"
gem "devise-security", "~> 0.17.0"

# Error and Performance Monitoring
gem "sentry-rails", "~> 5.3"
gem "sentry-ruby", "~> 5.4"

# Admin panel
gem "administrate", "~> 0.18.0"
gem "sprockets-rails", "~> 3.4", require: "sprockets/railtie"

# Money handling
gem "money-rails", "~> 1.15"

# Emails
gem "MailchimpTransactional", "~> 1.0", ">= 1.0.47"

# Background processing
gem "sidekiq", github: "mperham/sidekiq", ref: "09dacfed8f3f0b42833122b138639d22c71e3d56"

# s3 bucket
gem "aws-sdk-s3"

group :development do
  gem "lefthook", "~> 1.0", ">= 1.0.5"
  gem "solargraph", "~> 0.47.0"
  gem "yard", "~> 0.9.28", require: false
end

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "brakeman", "~> 5.2", ">= 5.2.3", require: false
  gem "bundler-audit", "~> 0.9.1", require: false
  gem "dotenv-rails", "~> 2.1", ">= 2.1.1", require: "dotenv/rails-now"
  gem "factory_bot_rails", "~> 6.2"
  gem "faker", "~> 2.22"
  gem "standard", "~> 1.14", require: false
  gem "rspec-rails", "~> 5.1", ">= 5.1.2"
  gem "rswag-specs", "~> 2.5", ">= 2.5.1"
  gem "rubocop-rails", "~> 2.15", ">= 2.15.2", require: false
  gem "rubocop-rspec", "~> 2.12", ">= 2.12.1", require: false
end

group :test do
  gem "rspec-sidekiq", "~> 3.1"
end
