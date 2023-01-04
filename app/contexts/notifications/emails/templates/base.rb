module Notifications
  module Emails
    module Templates
      class Base
        def required_fields
          raise NotImplementedError.new("Please set the required fields")
        end

        def name
          raise NotImplementedError.new("Please set the template name")
        end

        def subject
          raise NotImplementedError.new("Please set the email subject")
        end

        def from_email
          "jaltech@#{ENV["MAILCHIMP_EMAIL_DOMAIN"]}"
        end

        def from_name
          "Jaltech"
        end

        def content
          [{}]
        end

        def global_merge_vars
          raise NotImplementedError.new("Please set the global merge variables")
        end

        def valid?
          required_fields.all? do |required_field|
            global_merge_vars.find do |key_value|
              key_value[:name].eql?(required_field) && key_value[:content]&.present?
            end
          end
        end

        def to_json
          {
            from_email: from_email,
            from_name: from_name,
            name: name,
            subject: subject,
            content: content,
            global_merge_vars: global_merge_vars
          }.to_json
        end
      end
    end
  end
end
