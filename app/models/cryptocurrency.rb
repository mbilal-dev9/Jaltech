# frozen_string_literal: true

class Cryptocurrency < ApplicationRecord
  has_many :product_cryptocurrencies, dependent: :restrict_with_error
  has_many :products, through: :product_cryptocurrencies

  enum category: {digital_currency: "digital_currency", blockchain_technology: "blockchain_technology", decentralized_finance: "decentralized_finance"}

  validates :name, :code, :category, presence: true
end
