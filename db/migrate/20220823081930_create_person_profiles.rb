class CreatePersonProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :person_profiles, id: :uuid do |t|
      t.uuid :person_id, null: false, foreign_key: true
      t.uuid :profile_id, null: false, foreign_key: true
      t.string :user_type, null: false
      t.timestamps
    end

    add_index :person_profiles, [:profile_id, :user_type], unique: true
  end
end
