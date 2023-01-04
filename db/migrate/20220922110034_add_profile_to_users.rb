class AddProfileToUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :investors, :user_id, :uuid
    remove_column :advisors, :user_id, :uuid
    remove_column :companies, :user_id, :uuid

    reversible do |dir|
      change_table :users do |t|
        t.uuid :profile_id, null: false, foreign_key: true
        dir.up { t.change :user_type, :string, null: false }
        dir.down { t.enum :user_type, enum_type: "user_types", default: "investor", null: false }
      end
    end

    add_index :users, [:profile_id, :user_type], unique: true
  end
end
