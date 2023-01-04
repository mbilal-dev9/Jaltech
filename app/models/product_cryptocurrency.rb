class ProductCryptocurrency < ApplicationRecord
  belongs_to :product
  belongs_to :cryptocurrency
end
