# https://docs.sentry.io/platforms/ruby/guides/rails/
Sentry.init do |config|
  config.dsn = ENV["SENTRY_DSN"]
  config.breadcrumbs_logger = [:active_support_logger]

  config.traces_sampler = lambda do |sampling_context|
    unless sampling_context[:parent_sampled].nil?
      next sampling_context[:parent_sampled]
    end

    transaction_context = sampling_context[:transaction_context]
    op = transaction_context[:op]
    transaction_name = transaction_context[:name]

    Rails.logger.warn "Sentry config has to be customized"

    case op
    when /request/
      case transaction_name # transaction name is very often similar to your partial path
      when /payments_or_something_really_valuable_for_your_app/ # here is heart and critical part of your app
        1.0
      when /important_part_of_application/ # consider it as big priority, but business value is not there
        0.5
      when /heartbeat/ # consider it as very small priority
        0.01
      else
        0.1
      end
    when /sidekiq/
      0.1 # you may want to set a lower rate for background jobs if the number is large
    else
      0.0 # ignore all other transactions
    end
  end
end

Sentry.capture_message "Starting Application", level: :info
