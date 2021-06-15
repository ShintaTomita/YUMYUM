class CreateChefs < ActiveRecord::Migration[6.1]
  def change
    create_table :chefs do |t|
      t.string :name
      t.string :image
      t.string :shop_name
      t.string :shop_url
      t.string :address
      t.string :shop_tel
      t.text :introduction

      t.timestamps
    end
  end
end
