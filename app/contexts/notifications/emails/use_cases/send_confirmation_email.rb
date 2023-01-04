module Notifications
  module Emails
    module UseCases
      class SendConfirmationEmail
        class EmailTemplateNotValid < StandardError; end

        attr_reader :email

        def initialize(email)
          @email = email
        end

        def call
          populate_template
          validate_template

          SendTemplateEmailJob.perform_async(email, template.to_json)
        end

        private

        def populate_template
          person = user.profile.person
          template.first_name = person.first_name
          template.user_type = user.user_type
          template.confirmation_url = confirmation_url(user.confirmation_token)
        end

        def validate_template
          raise EmailTemplateNotValid.new("Please define all required fields in template: #{template.required_fields}") unless template.valid?
        end

        def confirmation_url(token)
          Rails.application.routes.url_helpers.api_v1_user_confirmation_url(confirmation_token: token, host: ENV["APPLICATION_HOST"])
        end

        def user
          @user ||= User.find_by(email: email)
        end

        def template
          @template ||= Notifications::Emails::Templates::EmailConfirmation.new
        end
      end
    end
  end
end
