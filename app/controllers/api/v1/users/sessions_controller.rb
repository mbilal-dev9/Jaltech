# frozen_string_literal: true

module Api
  module V1
    module Users
      class SessionsController < DeviseTokenAuth::SessionsController
        protect_from_forgery with: :null_session
      end
    end
  end
end
