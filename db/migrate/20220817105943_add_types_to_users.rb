class AddTypesToUsers < ActiveRecord::Migration[7.0]
  def up
    # enums cannot be dropped
    create_enum :user_types, %w[investor company advisor]

    change_table :users do |t|
      t.enum :user_type, enum_type: "user_types"
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
