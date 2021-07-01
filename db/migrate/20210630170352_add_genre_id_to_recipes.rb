class AddGenreIdToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :genre_id, :integer
  end
end
