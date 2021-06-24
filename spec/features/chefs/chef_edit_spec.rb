require "rails_helper"

RSpec.feature "シェフ情報の編集、削除について",type: :feature do
  given!(:chef) { create(:chef) }
  given!(:other_chef) { create(:chef, id: 201, name: "testuser2",
                                      email: "testuser2@example.com", password: "testothrechef", password_confirmation: "testothrechef") }

  background do
    sign_in chef
    visit "/yumyum/chefs/#{chef.id}/edit"
  end

  scenario "情報を更新した場合" do
    fill_in "chef_shop_name", with: "testshop"
    fill_in "chef_shop_tel", with: "123456789"
    fill_in "chef_address", with: "兵庫県"
    fill_in "chef_introduction", with: "Hello,World"
    click_on "プロフィール登録"
    expect(page).to have_content "プロフィールを更新しました"
    expect(current_path).to eq "/yumyum/chefs/#{chef.id}"
    expect(page).to have_content "testshop"
  end
  scenario "プロフィール編集のリンクはログインしたユーザ-idのみ表示されているか" do

  end
  scenario "アカウントを削除した場合" do
    click_on "アカウントを削除"
    expect(page).to have_content "アカウントを削除しました"
    expect(current_path).to eq yumyum_root_path
    visit "yumyum/chefs/#{chef.id}"
    expect(current_path).to eq new_yumyum_chef_path
  end

  scenario "プロフィール編集のリンクはログインしたユーザ-idのみ表示されているか" do
    visit "/yumyum/chefs/#{chef.id}"
    expect(page).to have_link "プロフィール編集"
    visit "/yumyum/chefs/#{other_chef.id}"
  end
end
