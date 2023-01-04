class RemovePerfonalInfoFromProfiles < ActiveRecord::Migration[7.0]
  def change
    remove_column :advisors, :contact_person, :string
    remove_column :companies, :contact_person, :string
    change_table :investors, bulk: true do
      remove_column :investors, :first_name, :string
      remove_column :investors, :last_name, :string
    end
  end
end
