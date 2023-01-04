class AddColumnsToPeople < ActiveRecord::Migration[7.0]
  def change
    create_enum :residential_status, %w[sa_resident non_resident foreign_national]

    reversible do |dir|
      change_table :people, bulk: true do |t|
        t.string :title
        t.string :nationality
        t.string :country_of_birth
        t.string :place_of_birth
        t.string :rsa_number
        t.string :foreign_id
        t.string :sa_tax_number
        t.string :email
        t.string :phone_no
        t.string :employer
        t.string :occupation
        t.string :employment_nature
        t.string :job_title
        t.string :previous_employment
        t.string :occupation_jurisdiction
        t.enum :residential_status, enum_type: "residential_status"
        t.uuid :profile_id, null: false, foreign_key: true
        t.string :user_type, null: false
        dir.up do
          t.change :first_name, :string, null: false
          t.change :last_name, :string, null: false
        end
        dir.down do
          t.change :first_name, :string
          t.change :last_name, :string
        end
      end
    end
    add_index :people, [:profile_id, :user_type], unique: true
  end
end
