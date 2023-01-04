class CreateAdvisors < ActiveRecord::Migration[7.0]
  def change
    create_table :advisors, id: :uuid do |t|
      t.string :company_name
      t.string :contact_person
      t.uuid :user_id
      t.timestamps
    end
  end
end
