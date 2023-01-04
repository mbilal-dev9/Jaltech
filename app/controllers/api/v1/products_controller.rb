# frozen_string_literal: true

module Api
  module V1
    class ProductsController < Api::ApiController
      def index
        render_ok(serialize(repo.load_all, each_serializer: ::Api::V1::ProductSerializer))
      end

      def show
        render_ok(serialize(repo.find_with_cryptocurrencies(id: params[:id]),
          serializer: ::Api::V1::ProductDetailsSerializer))
      rescue Client::Product::Repository::ProductNotFound => e
        render_not_found(e)
      end

      private

      def repo
        @products_repo ||= Client::Product::Repository.new
      end
    end
  end
end
