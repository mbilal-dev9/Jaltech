module Notifications
  module Emails
    module Templates
      class PasswordReset < Base
        attr_accessor :reset_password_url

        def required_fields
          %i[reset_password_url]
        end

        def name
          "Jaltech_user_password_reset"
        end

        def subject
          "Password Reset"
        end

        def global_merge_vars
          [
            {name: :reset_password_url, content: reset_password_url}
          ]
        end
      end
    end
  end
end
