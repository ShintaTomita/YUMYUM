class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :seasoning
      t.text :advise
      t.string :main_image
      t.string :process
      t.string :images
      t.integer :user_id
      t.integer :chef_id

      t.timestamps
    end
  end
end
