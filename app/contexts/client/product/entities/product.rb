# frozen_string_literal: true

module Client
  module Product
    module Entities
      class Product < ActiveModelSerializers::Model
        attributes :id, :name, :description, :category, :cryptocurrencies
      end
    end
  end
end
