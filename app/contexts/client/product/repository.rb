# frozen_string_literal: true

module Client
  module Product
    class Repository
      class ProductNotFound < StandardError; end

      def initialize(model = ::Product)
        @model = model
      end

      def load_all
        model.find_each.map(&method(:map_record))
      end

      def find_with_cryptocurrencies(id:)
        map_record(model.includes(:cryptocurrencies).find(id))
      rescue ActiveRecord::RecordNotFound
        raise ProductNotFound.new(I18n.t("api.v1.errors.record_not_found"))
      end

      private

      attr_reader :model

      def map_record(record)
        Client::Product::Entities::Product.new.tap do |product|
          product.id = record.id
          product.name = record.name
          product.category = record.category
          product.description = record.description
          product.cryptocurrencies = record.cryptocurrencies
        end
      end
    end
  end
end
