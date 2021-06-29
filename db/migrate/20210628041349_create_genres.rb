class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres do |t|
      t.string :genre_name
      t.string :price

      t.timestamps
    end
  end
end
