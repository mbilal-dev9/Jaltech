# frozen_string_literal: true

module Client
  module User
    module UseCases
      class SignUp
        class ValidationError < StandardError
          attr_reader :record_errors

          def initialize(message, record_errors)
            @record_errors = record_errors
            super(message)
          end
        end

        def initialize(user_model: ::User)
          @user_model = user_model
        end

        def call(params:)
          create_user(params)
        end

        private

        attr_reader :user_model

        def create_user(params)
          build_entity(params).save!
          Notifications::Emails::UseCases::SendConfirmationEmail.new(params[:email]).call
        rescue ActiveRecord::RecordInvalid => e
          raise ValidationError.new(e, e.record.errors)
        end

        def build_entity(params)
          user_model.new(params)
        end
      end
    end
  end
end
