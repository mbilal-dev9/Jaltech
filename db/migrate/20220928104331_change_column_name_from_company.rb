class ChangeColumnNameFromCompany < ActiveRecord::Migration[7.0]
  def change
    rename_column :companies, :name, :company_name
  end
end
