class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies, id: :uuid do |t|
      t.string :name
      t.string :contact_person
      t.uuid :user_id
      t.timestamps
    end
  end
end
