# frozen_string_literal: true

module Api
  module V1
    class ProductDetailsSerializer < ActiveModel::Serializer
      attributes :id, :name, :description, :category
      has_many :cryptocurrencies, serializer: CryptocurrencySerializer
    end
  end
end
