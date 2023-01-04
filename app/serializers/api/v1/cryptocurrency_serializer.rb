# frozen_string_literal: true

module Api
  module V1
    class CryptocurrencySerializer < ActiveModel::Serializer
      attributes :id, :name, :code, :category
    end
  end
end
