# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'レシピ新規登録の有効性', type: :feature do
  given!(:chef) { create(:chef) }

  background do
    sign_in chef
    visit "/yumyum/recipes/new"
  end

  scenario '新規登録ができるか?' do
    find("#recipe_chef_id", visible: false).set(chef.id)
    fill_in "recipe_name", with: "testrecipe"
    choose "recipe_genre_id_1"
    fill_in "recipe_food_stuff", with: "test_food_stuff"
    attach_file("recipe[main_image]", "#{Rails.root}/app/assets/images/sample_recipe.jpg")
    fill_in "recipe_first_process", with: "testprocess"
    attach_file("recipe[first_image]", "#{Rails.root}/app/assets/images/sample_recipe.jpg")
    fill_in "recipe_second_process", with: "testprocess"
    attach_file("recipe[second_image]", "#{Rails.root}/app/assets/images/sample_recipe.jpg")
    fill_in "recipe_third_process", with: "testprocess"
    attach_file("recipe[third_image]", "#{Rails.root}/app/assets/images/sample_recipe.jpg")
    fill_in "recipe_fourth_process", with: "testprocess"
    attach_file("recipe[fourth_image]", "#{Rails.root}/app/assets/images/sample_recipe.jpg")
    fill_in "recipe_advise", with: "testadvise"
    click_on "レシピ登録"
    expect(page).to have_content "レシピを登録しました"
  end
end
