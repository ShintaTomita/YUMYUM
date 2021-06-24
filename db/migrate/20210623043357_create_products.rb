class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.integer  :user_id
      t.integer  :recipe_id
      t.timestamps
    end
  end
end
