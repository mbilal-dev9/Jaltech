# frozen_string_literal: true

require "MailchimpTransactional"

module Emails
  class MailchimpClient
    class EmailNotSent < StandardError; end

    def initialize(client = MailchimpTransactional::Client.new(ENV["MAILCHIMP_API_KEY"]))
      @client = client
    end

    def send_email(template_name, template_content, message)
      client.messages.send_template(payload(template_name, template_content, message))
    rescue MailchimpTransactional::ApiError => e
      raise EmailNotSent.new(e.message)
    end

    private

    attr_reader :client

    def payload(template_name, template_content, message)
      {
        template_name: template_name,
        template_content: template_content,
        message: message
      }
    end
  end
end
