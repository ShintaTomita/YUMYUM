class RemoveUserIdFromRecipes < ActiveRecord::Migration[6.1]
  def change
    remove_column :recipes, :user_id, :integer
  end
end
