# frozen_string_literal: true

require "rails_helper"

RSpec.describe Client::User::UseCases::SignUp do
  describe "#call" do
    subject(:sign_up_use_case) { described_class.new(user_model: ::User).call(params: params) }

    let(:email) { "user@example.com" }
    let(:password) { "P4$$word1" }
    let(:shared_params) {
      {
        email: email,
        password: password,
        password_confirmation: password
      }.with_indifferent_access
    }

    context "when all params are correct" do
      let(:params) do
        shared_params.merge(
          {
            user_type: "Investor",
            profile_attributes: {
              person_attributes: {
                first_name: "First name",
                last_name: "Last name"
              }
            }
          }
        )
      end

      it { expect { sign_up_use_case }.to change { [User.count, Investor.count] }.from([0, 0]).to([1, 1]) }
    end

    context "when user type is not given" do
      let(:params) do
        shared_params.merge(
          {
            user_type: nil,
            profile_attributes: {
              person_attributes: {
                first_name: "First name",
                last_name: "Last name"
              }
            }
          }
        )
      end

      it "raise error when user enter invalid user type" do
        expect { sign_up_use_case }.to raise_error(RuntimeError, "Unknown user_type: ")
      end
    end

    context "when personal information is not given" do
      let(:params) do
        shared_params.merge(
          {
            user_type: "Investor",
            profile_attributes: {
              person_attributes: {
              }
            }
          }
        )
      end

      it { expect { sign_up_use_case }.to raise_error(Client::User::UseCases::SignUp::ValidationError) }
    end
  end
end
