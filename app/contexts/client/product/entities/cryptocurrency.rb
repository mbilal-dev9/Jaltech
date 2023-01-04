# frozen_string_literal: true

module Client
  module Product
    module Entities
      class Cryptocurrency < ActiveModelSerializers::Model
        attributes :id, :name, :code, :category
      end
    end
  end
end
