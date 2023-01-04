# frozen_string_literal: true

module Api
  module V1
    module Users
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        protect_from_forgery with: :null_session

        def create
          resource = Client::User::UseCases::SignUp.new.call(params: sign_up_params)

          render json: {status: "success", data: resource}, status: :created
        rescue Client::User::UseCases::SignUp::ValidationError => e
          render json: {error: e.record_errors, code: 422}, status: :unprocessable_entity
        end

        private

        def sign_up_params
          params.permit(:email, :password, :password_confirmation, :user_type, :company_name,
            profile_attributes: [:name, person_attributes: [:first_name, :last_name]])
        end
      end
    end
  end
end
