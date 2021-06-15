class ChangeDataShopTelToChefs < ActiveRecord::Migration[6.1]
  def change
    change_column :chefs, :shop_tel, :string
  end
end
