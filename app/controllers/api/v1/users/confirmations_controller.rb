# frozen_string_literal: true

module Api
  module V1
    module Users
      class ConfirmationsController < DeviseTokenAuth::ConfirmationsController
        protect_from_forgery with: :null_session

        def show
          @resource = resource_class.confirm_by_token(resource_params[:confirmation_token])

          redirect_header_options = if @resource.errors.empty?
            {account_confirmation_success: true}
          else
            {account_confirmation_success: false}
          end

          redirect_to_link = DeviseTokenAuth::Url.generate("#{ENV["FRONTEND_HOST"]}/login", redirect_header_options)
          redirect_to(redirect_to_link, allow_other_host: true)
        end
      end
    end
  end
end
