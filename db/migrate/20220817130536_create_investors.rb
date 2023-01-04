class CreateInvestors < ActiveRecord::Migration[7.0]
  def change
    create_table :investors, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.uuid :user_id

      t.timestamps
    end
  end
end
