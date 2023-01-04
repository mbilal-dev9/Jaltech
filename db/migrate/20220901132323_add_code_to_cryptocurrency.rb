class AddCodeToCryptocurrency < ActiveRecord::Migration[7.0]
  def change
    rename_column :cryptocurrencies, :acronym, :code
  end
end
