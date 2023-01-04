# frozen_string_literal: true

require "rails_helper"

RSpec.describe Notifications::Emails::UseCases::SendConfirmationEmail do
  let(:user) { create(:user) }
  let(:send_confirmation_email) { described_class.new(user.email) }
  let(:template) { Notifications::Emails::Templates::EmailConfirmation.new }

  context "when all required fields are populated" do
    before do
      person = user.profile.person
      template.first_name = person.first_name
      template.user_type = user.user_type
      template.confirmation_url = Rails.application.routes.url_helpers.api_v1_user_confirmation_url(confirmation_token: user.confirmation_token, host: ENV["APPLICATION_HOST"])
    end

    it "calls SendTemplateEmailJob" do
      send_confirmation_email.call

      expect(SendTemplateEmailJob).to have_enqueued_sidekiq_job(user.email, template.to_json)
    end
  end

  context "when all required fields are not populated" do
    before do
      template.first_name = nil
      template.user_type = nil
      template.confirmation_url = nil
    end

    it "does not call SendTemplateEmailJob" do
      send_confirmation_email.call

      expect(SendTemplateEmailJob).not_to have_enqueued_sidekiq_job(user.email, template.to_json)
    end
  end
end
