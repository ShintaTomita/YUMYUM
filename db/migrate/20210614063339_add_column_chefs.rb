class AddColumnChefs < ActiveRecord::Migration[6.1]
  def change
    add_column :chefs, :address, :string
  end
end
