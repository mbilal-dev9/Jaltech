require "swagger_helper"

RSpec.describe "api/v1/people/:id", type: :request do
  path "/api/v1/people/:id" do
    patch("Update user information") do
      tags "people"
      description "user personal information form"
      consumes "application/json"
      produces "application/json"
      parameter name: :payload, in: :body, schema: {
        type: :object,
        required: %w[first_name last_name title nationality country_of_birth place_of_birth rsa_number sa_tax_number email phone_no],
        properties: {
          first_name: {type: :string, example: "First Name"},
          last_name: {type: :string, example: "Last Name"},
          title: {type: :string, example: "Title"},
          nationality: {type: :string, example: "Nationality"},
          country_of_birth: {type: :string, example: "Country of Birth"},
          place_of_birth: {type: :string, example: "Place of Birth"},
          rsa_number: {type: :string, example: "Rsa Number"},
          email: {type: :string, example: "email@example.com"},
          phone_no: {type: :string, example: "Phone Number"},
          employer: {type: :string, example: "Employer"},
          occupation: {type: :string, example: "Occupation"},
          employment_nature: {type: :string, example: "Employment Nature"},
          job_title: {type: :string, example: "Job Title"},
          previous_employment: {type: :string, example: "Previous Employment"},
          occupation_jurisdiction: {type: :string, example: "Occupation Jurisdiction"}
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
          first_name: "First Name",
          last_name: "Last Name",
          title: "Title",
          nationality: "Nationality",
          country_of_birth: "Country of Birth",
          place_of_birth: "Place of Birth",
          rsa_number: "0834128458",
          sa_tax_number: "4012345678",
          phone_no: "0834128458",
          employer: "Employer",
          occupation: "Occupation",
          employment_nature: "Employment Nature",
          job_title: "Job Title",
          previous_employment: "Previous Employment",
          occupation_jurisdiction: "Occupation Jurisdiction",
          residential_status: "sa_resident",
          foreign_id: "test"
        }
      end

      response(200, "Personal Information Save Successfully") do
        schema type: :object,
          properties: {
            status: {
              type: :string,
              example: "success"
            },
            code: {
              type: :integer,
              example: 200
            },
            data: {
              type: :object,
              properties: {
                id: {
                  type: :string,
                  example: "82d46f27-d392-4962-b040-620be7b3ef84"
                },
                first_name: {
                  type: :string,
                  example: "First name"
                },
                last_name: {
                  type: :string,
                  example: "Last name"
                },
                phone_no: {
                  type: :string,
                  example: "Phone Number"
                },
                title: {
                  type: :string,
                  example: "Title"
                },
                residential_status: {
                  type: :string,
                  example: "sa_resident"
                },
                nationality: {
                  type: :string,
                  example: "test"
                },
                country_of_birth: {
                  type: :string,
                  example: "USA"
                },
                place_of_birth: {
                  type: :string,
                  example: "NY"
                },
                rsa_number: {
                  type: :string,
                  example: "81 874 2235"
                },
                foreign_id: {
                  type: :string,
                  example: "1234"
                },
                sa_tax_number: {
                  type: :string,
                  example: "+27 81 874 2235"
                },
                occupation: {
                  type: :string,
                  example: "test"
                },
                job_title: {
                  type: :string,
                  example: "job title"
                },
                employer: {
                  type: :string,
                  example: "test"
                },
                employment_nature: {
                  type: :string,
                  example: "test"
                },
                previous_employment: {
                  type: :string,
                  example: "test"
                }
              }
            }
          },
          required: %w[status code data]

        run_test! do |response|
          expect(response).to have_http_status(:ok)
        end

        it "Updates person info" do
          expect(JSON.parse!(response.body)["data"]["sa_tax_number"]).to eq("4012345678")
        end
      end

      response(422, "Entered Information is not processable") do
        schema type: :object,
          properties: {
            status: {
              type: :string,
              example: "error"
            },
            code: {
              type: :integer,
              example: 422
            }
          },
          required: %w[status code]

        let(:payload) do
          {
            first_name: nil,
            title: "Title",
            nationality: "Nationality",
            country_of_birth: "Country of Birth"
          }
        end
        run_test! do |response|
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      response(401, "Unauthorized") do
        schema type: :object,
          properties: {
            errors: {
              type: :array,
              example: "You need to sign in or sign up before continuing."
            }
          },
          required: %w[errors]

        # rubocop:disable RSpec/VariableName
        let(:"access-token") { "" }
        # rubocop:enable RSpec/VariableName
        run_test! do |response|
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
