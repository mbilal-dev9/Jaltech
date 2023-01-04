require "swagger_helper"

RSpec.describe "api/v1/users/registrations", type: :request do
  path "/api/v1/auth" do
    post("User registration") do
      tags "authentication"
      description "Creates a user with given profile"
      consumes "application/json"
      produces "application/json"
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          email: {type: :string, nullable: false, example: "email@example.com"},
          password: {type: :string, nullable: false, example: "Password1"},
          password_confirmation: {type: :string, nullable: false, example: "Password1"},
          user_type: {type: :string, nullable: false, example: "Investor/Advisor/Company"},
          profile_attributes: {type: :object, properties: {
            company_name: {type: :string, example: "Company name"},
            person_attributes: {type: :object, properties: {
              first_name: {type: :string, example: "First name"},
              last_name: {type: :string, example: "Last name"}
            }}
          }}
        },
        required: %w[email password password_confirmation]
      }

      let(:payload) { {} }

      response(201, "created") do
        schema type: :object,
          properties: {
            status: {
              type: :string,
              example: "success"
            },
            data: {
              type: :string,
              example: "808c5be88684aa4a11566205"
            }
          },
          required: %w[status data]

        let(:payload) do
          {
            email: "address@email.com",
            password: "Password1",
            password_confirmation: "Password1",
            user_type: "Advisor",
            profile_attributes: {
              person_attributes: {
                first_name: "First name",
                last_name: "Last name"
              }
            }
          }
        end

        it "creates new user" do |example|
          expect { submit_request(example.metadata) }.to change { User.all.count }.by(1)
        end
      end

      response(422, "Validation error (ie. password is not valid)") do
        schema type: :object,
          properties: {
            error: {
              type: :object,
              properties: {
                email: {
                  type: :array,
                  example: ["has already been taken"]
                },
                base: {
                  type: :array,
                  example: ["has too many profiles attributes"]
                }
              }
            },
            code: {
              type: :integer,
              example: 422
            }
          },
          required: %w[error]

        let(:payload) do
          {
            email: "address@email.com",
            password: "Password",
            password_confirmation: "Password",
            user_type: "Investor",
            profile_attributes: {
              company_name: "Company name",
              person_attributes: {
                first_name: "First name",
                last_name: "Last name"
              }
            }
          }
        end

        run_test! do
          expect(JSON.parse(response.body)["error"]["password"]).to match_array(["is too short (minimum is 9 characters)", "must contain at least one digit"])
        end

        it "does not create new user" do |example|
          expect { submit_request(example.metadata) }.not_to change { User.all.count }
        end
      end
    end
  end
end
