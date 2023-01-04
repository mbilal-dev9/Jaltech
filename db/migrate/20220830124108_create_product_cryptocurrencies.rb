class CreateProductCryptocurrencies < ActiveRecord::Migration[7.0]
  def change
    create_table :product_cryptocurrencies, id: :uuid do |t|
      t.uuid :product_id, null: false, foreign_key: true
      t.uuid :cryptocurrency_id, null: false, foreign_key: true
      t.timestamps
    end
  end
end
