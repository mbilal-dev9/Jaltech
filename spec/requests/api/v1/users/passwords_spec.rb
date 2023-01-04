require "swagger_helper"

RSpec.describe "api/v1/users/passwords", type: :request do
  path "/api/v1/auth/password" do
    post("Send password reset URL") do
      tags "authentication"
      description "Email's user password reset link"
      consumes "application/json"
      produces "application/json"
      parameter name: :payload, in: :body, schema: {
        type: :object,
        required: %w[email],
        properties: {
          email: {type: :string, nullable: false, example: "email@example.com"}
        }
      }

      let(:user) { create(:user, confirmed_at: DateTime.current, email: "email@example.com") }
      let(:email) { user.email }

      let(:payload) do
        {
          email: email
        }
      end

      response(200, "reset password request sent") do
        schema type: :object,
          properties: {
            success: {
              type: :boolean,
              example: true
            },
            message: {
              type: :string,
              example: "An email has been sent to 'email@example.com' containing instructions for resetting your password."
            }
          },
          required: %w[success message]

        run_test! do |response|
          expect(response).to have_http_status(:ok)
        end

        it "sends password reset email" do |example|
          expect { submit_request(example.metadata) }.to change { user.reload.reset_password_token }
        end
      end

      response(404, "User with provided email not found") do
        schema type: :object,
          properties: {
            success: {
              type: :boolean,
              example: false
            },
            errors: {
              type: :array,
              example: "Unable to find user with email 'email@example.com'."
            }
          },
          required: %w[errors]

        let(:payload) do
          {
            email: "address123@email.com"
          }
        end

        run_test! do |response|
          expect(response).to have_http_status(:not_found)
        end

        it "user with given email not found" do |example|
          expect { submit_request(example.metadata) }.not_to change { user.reload.reset_password_token }
        end
      end
    end

    put("Update password through reset URL") do
      raw, enc = Devise.token_generator.generate(User, :reset_password_token)
      tags "authentication"
      description "Update password if reset_password_token is valid"
      consumes "application/json"
      produces "application/json"
      parameter name: :payload, in: :body, schema: {
        type: :object,
        required: %w[reset_password_token password password_confirmation],
        properties: {
          reset_password_token: {type: :string, nullable: false, example: raw},
          password: {type: :string, nullable: false, example: "Password123"},
          password_confirmation: {type: :string, nullable: false, example: "Password123"}
        }
      }
      let!(:user) do
        create(:user, confirmed_at: DateTime.current, reset_password_token: enc, reset_password_sent_at: DateTime.current, allow_password_change: true)
      end
      let(:payload) do
        {
          reset_password_token: raw,
          password: "Password1234",
          password_confirmation: "Password1234"
        }
      end

      response(200, "Reset password request sent") do
        schema type: :object,
          properties: {
            success: {
              type: :boolean,
              example: true
            },
            message: {
              type: :string,
              example: "password successfully updated."
            }
          },
          required: %w[success message]

        run_test! do |response|
          expect(response).to have_http_status(:ok)
        end

        it "Reset the reset_password_token" do |example|
          submit_request(example.metadata)
          user.reload
          expect(user.reset_password_token).to be_nil
        end
      end

      response(401, "User with provided reset_password_token not found") do
        schema type: :object,
          properties: {
            success: {
              type: :boolean,
              example: false
            },
            errors: {
              type: :array,
              example: ["Unauthorized"]
            }
          },
          required: %w[errors]

        let(:payload) do
          {
            reset_password_token: "123123123",
            password: "Password1234",
            password_confirmation: "Password1234"
          }
        end

        run_test! do |response|
          expect(response).to have_http_status(:unauthorized)
        end

        it "user with given reset_password_token not found" do |example|
          expect { submit_request(example.metadata) }.not_to change { user.reload.password }
        end
      end
    end

    patch("Change password through old password for authenticated users") do
      tags "authentication"
      description "Change password if old password is correct and user is logged in"
      consumes "application/json"
      produces "application/json"
      parameter name: :payload, in: :body, schema: {
        type: :object,
        required: %w[current_password password password_confirmation],
        properties: {
          current_password: {type: :string, nullable: false, example: "Password1"},
          password: {type: :string, nullable: false, example: "Password123"},
          password_confirmation: {type: :string, nullable: false, example: "Password123"}
        }
      }
      parameter name: "access-token", in: :header, type: :string
      parameter name: "client", in: :header, type: :string
      parameter name: "uid", in: :header, type: :string

      let(:user) { create(:user, confirmed_at: DateTime.current, email: "email@example.com") }
      let(:auth_headers) { user.create_new_auth_token }
      let(:uid) { auth_headers["uid"] }
      let(:client) { auth_headers["client"] }
      # rubocop:disable RSpec/VariableName
      let(:"access-token") { auth_headers["access-token"] }
      # rubocop:enable RSpec/VariableName
      let(:payload) do
        {
          current_password: "Password1",
          password: "Password1234",
          password_confirmation: "Password1234"
        }
      end

      response(200, "password successfully updated.") do
        schema type: :object,
          properties: {
            success: {
              type: :boolean,
              example: true
            },
            message: {
              type: :string,
              example: "password successfully updated."
            }
          },
          required: %w[success message]

        run_test! do |response|
          expect(response).to have_http_status(:ok)
        end
      end

      response(422, "Old password is incorrect") do
        schema type: :object,
          properties: {
            success: {
              type: :boolean,
              example: false
            },
            errors: {
              type: :object,
              example: {
                current_password: [
                  "is invalid"
                ],
                full_messages: [
                  "Current password is invalid"
                ]
              }
            }
          },
          required: %w[errors]

        let(:payload) do
          {
            current_password: "Password2",
            password: "Password1234",
            password_confirmation: "Password1234"
          }
        end

        run_test! do |response|
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end
end
