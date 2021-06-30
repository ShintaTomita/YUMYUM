class ChangeDataShopUrlToChefs < ActiveRecord::Migration[6.1]
  def change
    change_column :chefs, :shop_url, :string
  end
end
