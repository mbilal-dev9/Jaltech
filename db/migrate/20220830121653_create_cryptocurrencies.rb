class CreateCryptocurrencies < ActiveRecord::Migration[7.0]
  def up
    # enums cannot be dropped
    create_enum :cryptocurrency_categories, %w[digital_currency blockchain_technology decentralized_finance]

    create_table :cryptocurrencies, id: :uuid do |t|
      t.string :name, null: false
      t.string :acronym, null: false
      t.enum :category, enum_type: "cryptocurrency_categories", default: "digital_currency", null: false
      t.timestamps
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
