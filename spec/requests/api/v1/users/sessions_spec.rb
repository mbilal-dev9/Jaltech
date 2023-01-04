require "swagger_helper"

RSpec.describe "auth/controllers/sessions", type: :request, capture_examples: true do
  path "/api/v1/auth/sign_in" do
    post("Log in") do
      tags "authentication"
      consumes "application/json"
      produces "application/json"
      parameter name: :login, in: :body, schema: {
        type: :object,
        required: %w[email password],
        properties: {
          email: {
            type: :string,
            example: "test@example.com"
          },
          password: {
            type: :string
          }
        }
      }

      let(:user) { create(:user, confirmed_at: DateTime.current) }
      let(:email) { user.email }
      let(:password) { user.password }

      let(:login) do
        {
          email: email,
          password: password
        }
      end

      response(200, "User logged in") do
        schema type: :object,
          required: %w[data],
          properties: {
            data: {
              type: :object,
              properties: {
                id: {
                  type: :string,
                  example: "82d46f27-d392-4962-b040-620be7b3ef84"
                },
                email: {
                  type: :string,
                  example: "test@example.com"
                },
                user_type: {
                  type: :string,
                  example: "advisor"
                },
                provider: {
                  type: :string,
                  example: "email"
                },
                uid: {
                  type: :string,
                  example: "test@example.com"
                },
                allow_password_change: {
                  type: :boolean,
                  example: false
                }
              },
              required: %w[id email user_type]
            }
          }

        run_test! do
          expect(JSON.parse!(response.body)["data"]["id"]).to eq(user.id)
        end

        it "creates new token" do |example|
          expect { submit_request(example.metadata) }.to change { user.reload.tokens.count }.by(1)
        end
      end

      response(401, "Invalid credentials") do
        let(:password) { "invalid" }

        schema type: :object,
          required: %w[success errors],
          properties: {
            success: {type: :boolean, example: false},
            errors: {
              type: :array,
              items: {type: :string, example: "Invalid login credentials. Please try again."}
            }
          }

        run_test! do
          expect(JSON.parse!(response.body)).to eq({success: false, errors: ["Invalid login credentials. Please try again."]}.as_json)
        end

        it "does not create new token" do |example|
          expect { submit_request(example.metadata) }.not_to change { user.reload.tokens.count }
        end

        context "when user account was not confirmed" do
          let(:user) { create(:user) }
          let(:password) { user.password }

          run_test!

          it "returns invalid credentials error" do |example|
            submit_request(example.metadata)
            expect(JSON.parse!(response.body)).to eq({success: false, errors: ["A confirmation email was sent to your account at '#{user.email}'. You must follow the instructions in the email before your account can be activated"]}.as_json)
          end

          it "does not create new token" do |example|
            expect { submit_request(example.metadata) }.not_to change { user.reload.tokens.count }
          end
        end
      end
    end
  end

  path "/api/v1/auth/sign_out" do
    delete("Log out") do
      consumes "application/json"
      produces "application/json"
      tags "authentication"
      description "Invalidates currently active bearer token"

      parameter name: "access-token", in: :header, type: :string
      parameter name: "client", in: :header, type: :string
      parameter name: "uid", in: :header, type: :string

      let(:user) { create(:user, confirmed_at: DateTime.now) }
      let(:token) { user.create_token }
      # rubocop:disable RSpec/VariableName
      let(:"access-token") { token.token }
      # rubocop:enable RSpec/VariableName
      let(:client) { token.client }
      let(:uid) { user.uid }

      response(200, "Success - user logged off") do
        before do
          token
          user.save!
        end

        schema type: :object,
          properties: {
            success: {type: :boolean, example: true}
          }

        run_test! do |response|
          expect(response).to have_http_status(:ok)
        end
      end

      response(404, "Error - user not logged in") do
        schema type: :object,
          required: %w[success errors],
          properties: {
            success: {type: :boolean, example: false},
            errors: {
              type: :array,
              items: {type: :string, example: "User was not found or was not logged in."}
            }
          }

        run_test! do |response|
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
