class CreateProducts < ActiveRecord::Migration[7.0]
  def up
    # enums cannot be dropped
    create_enum :product_categories, %w[cryptocurrency private_debt]

    create_table :products, id: :uuid do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.enum :category, enum_type: "product_categories", default: "cryptocurrency", null: false

      t.timestamps
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
