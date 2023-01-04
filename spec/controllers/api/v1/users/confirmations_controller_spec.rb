# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::Users::ConfirmationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "GET #show" do
    let(:user) { create(:user) }
    let(:confirmation_token) { user.confirmation_token }
    let(:params) { {confirmation_token: confirmation_token} }

    before do
      request.env["devise.mapping"] = Devise.mappings[:api_v1_user]
    end

    it "returns http redirect" do
      get :show, params: {confirmation_token: confirmation_token}
      expect(response).to have_http_status(:found)
    end
  end
end
