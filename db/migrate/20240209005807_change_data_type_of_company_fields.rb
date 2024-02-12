class ChangeDataTypeOfCompanyFields < ActiveRecord::Migration[7.1]
  def change
    change_column :companies, :name, :text
    change_column :companies, :location, :text

    
  end
end
