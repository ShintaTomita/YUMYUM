require "rails_helper"

RSpec.feature "レシピ新規登録の有効性", type: :feature do
  given!(:chef) { create(:chef) }

  background do
    sign_in chef
    visit new_yumyum_recipe_path
  end

  scenario "新規登録ができるか?" do
    fill_in "recipe_name", with: "testrecipe"
    choose 'recipe_genre_主食'
    fill_in "recipe_food_stuff", with: "test_food_stuff"
    attach_file "recipe_main_image", "#{Rails.root}/spec/factories/sample.jpg"
    fill_in "recipe_first_process", with: "testprocess"
    attach_file "recipe_first_image", "#{Rails.root}/spec/factories/sample.jpg"
    find("#price", visible: false).set(500)
    fill_in "recipe_advise",with: "testadvise"
    click_on "レシピ登録"

  end
end
