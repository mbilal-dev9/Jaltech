module Api
  module V1
    module Users
      class PasswordsController < DeviseTokenAuth::PasswordsController
        protect_from_forgery with: :null_session

        protected

        def resource_update_method
          if request.params[:current_password].present?
            "update_with_password"
          else
            "update"
          end
        end
      end
    end
  end
end
