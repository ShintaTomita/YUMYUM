class AddGenreIdToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :genre_id, :integer
    remove_column :recipes, :price, :integer
  end
end
