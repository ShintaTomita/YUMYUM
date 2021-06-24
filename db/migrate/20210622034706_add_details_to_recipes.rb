class AddDetailsToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :price,      :integer
    add_column :recipes, :genre,      :string
    add_column :recipes, :product_id, :integer
  end
end
