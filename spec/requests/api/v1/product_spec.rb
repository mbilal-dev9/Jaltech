require "swagger_helper"

RSpec.describe "api/v1/products", type: :request do
  path "/api/v1/products" do
    get "Fetch products" do
      tags "products"
      produces "application/json"

      let!(:products) { create_list(:product, 2) }

      response(200, "Product list") do
        schema type: :object,
          required: %w[data],
          properties: {
            data: {
              type: :array,
              items: {
                type: :object,
                properties: {
                  id: {
                    type: :string,
                    example: "82d46f27-d392-4962-b040-620be7b3ef84"
                  },
                  name: {
                    type: :string,
                    example: "Bitcoin Debenture"
                  },
                  description: {
                    type: :string,
                    example: "Long description"
                  },
                  category: {
                    type: :string,
                    example: "cryptocurrency"
                  }
                },
                required: %w[id name description category]
              }
            }
          }

        run_test!

        it "returns all products" do
          expect(JSON.parse!(response.body)["data"].count).to eq(products.count)
        end
      end
    end
  end
end
