# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :product_cryptocurrencies, dependent: :destroy
  has_many :cryptocurrencies, through: :product_cryptocurrencies

  enum category: {cryptocurrency: "cryptocurrency", private_debt: "private_debt"}

  validates :name, :description, :category, presence: true
end
