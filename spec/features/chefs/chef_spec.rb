require "rails_helper"

RSpec.feature "before_actionメソッドの有効性について", type: :feature do
  given!(:chef) { create(:chef) }
  given!(:other_chef) { create(:chef, id: 201, name: "testuser2",
                                      email: "testuser2@example.com", password: "testothrechef", password_confirmation: "testothrechef") }

  background do
    visit yumyum_root_path
  end

  scenario "ログインしていないユーザーが他ユーザーのページへアクセスした場合" do
    visit "yumyum/chefs/#{chef.id}/edit"
    expect(current_path).to eq new_chef_session_path
  end

  scenario "ログインしているユーザーが他ユーザーのeditページへアクセスした場合" do
    sign_in chef
    visit "/yumyum/chefs/#{other_chef.id}/edit"
    expect(page).to have_content "権限がありません"
    expect(current_path).to eq yumyum_root_path
  end
end
