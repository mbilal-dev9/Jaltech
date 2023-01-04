module Notifications
  module Emails
    module Templates
      class EmailConfirmation < Base
        attr_accessor :first_name, :user_type, :confirmation_url

        def required_fields
          %i[first_name user_type confirmation_url]
        end

        def name
          "Jaltech_user_email_confirmation"
        end

        def subject
          "Email confirmation"
        end

        def global_merge_vars
          [
            {name: :first_name, content: first_name},
            {name: :user_type, content: user_type},
            {name: :confirmation_url, content: confirmation_url}
          ]
        end
      end
    end
  end
end
