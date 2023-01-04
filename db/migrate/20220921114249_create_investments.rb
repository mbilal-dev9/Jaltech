class CreateInvestments < ActiveRecord::Migration[7.0]
  def change
    create_table :investments, id: :uuid do |t|
      t.uuid :profile_id, null: false, foreign_key: true
      t.string :profile_type, null: false
      t.uuid :product_id, null: false, foreign_key: true
      t.monetize :amount, null: false
      t.timestamps
    end
  end
end
