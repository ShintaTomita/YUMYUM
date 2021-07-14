# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'レシピ新規登録の有効性', type: :system do
  let!(:chef) { create(:chef) }

  before do
    sign_in chef
    visit new_yumyum_recipe_path
  end

  describe "新規登録ができるか？" do
    it '新規登録ができるか?' do
      fill_in 'recipe_name', with: 'testrecipe'
      String value = chef.id
      ((JavascriptExecutor).webDriver).executeScript("document.getElementsByName('recipe_genre_id')").value = value
      choose "recipe_genre_id_1"
      fill_in 'recipe_food_stuff', with: 'test_food_stuff'
      attach_file("recipe_main_image", "app/assets/images/sample_recipe.jpg")
      fill_in 'recipe_first_process', with: 'testprocess'
      attach_file("recipe_first_image", "app/assets/images/sample_recipe.jpg")
      fill_in 'recipe_second_process', with: 'testprocess'
      attach_file("recipe_second_image", "app/assets/images/sample_recipe.jpg")
      fill_in 'recipe_third_process', with: 'testprocess'
      attach_file("recipe_third_image", "app/assets/images/sample_recipe.jpg")
      fill_in 'recipe_fourth_process', with: 'testprocess'
      attach_file("recipe_fourth_image", "app/assets/images/sample_recipe.jpg")
      fill_in 'recipe_advise', with: 'testadvise'
      click_on 'レシピ登録'
      expect(page).to have_content "レシピを登録しました"
    end
  end
end
