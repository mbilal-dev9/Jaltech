module Api
  class ApiController < ActionController::API
    include DeviseTokenAuth::Concerns::SetUserByToken
    alias_method :authenticate_user!, :authenticate_api_v1_user!
    alias_method :current_user, :current_api_v1_user

    def serialize(resource, options = {})
      ActiveModelSerializers::SerializableResource.new(resource, options)
    end

    def render_ok(data)
      render json: {data: data, code: 200, status: "success"}, status: :ok
    end

    def render_not_found(message)
      render json: {error: message, code: 404, status: "error"}, status: :not_found
    end

    def render_unprocessable_entity(message)
      render json: {error: message, code: 422, status: "error"}, status: :unprocessable_entity
    end
  end
end
