class AddColumnRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column    :recipes,    :first_process,  :string
    add_column    :recipes,    :second_process, :string
    add_column    :recipes,    :third_process,  :string
    add_column    :recipes,    :fourth_process, :string
    add_column    :recipes,    :first_image,    :string
    add_column    :recipes,    :second_image,   :string
    add_column    :recipes,    :third_image,    :string
    add_column    :recipes,    :fourth_image,   :string
    add_column    :recipes,    :food_stuff,     :string
    remove_column :recipes,    :process,        :string
    remove_column :recipes,    :images,         :string
    remove_column :recipes,    :seasoning,      :string
  end
end
