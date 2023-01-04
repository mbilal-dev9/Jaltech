# frozen_string_literal: true

module Api
  module V1
    class ProductSerializer < ActiveModel::Serializer
      attributes :id, :name, :description, :category
    end
  end
end
