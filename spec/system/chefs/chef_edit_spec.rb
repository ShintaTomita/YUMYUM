# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'シェフ情報の編集、削除について', type: :system do
  let!(:chef) { create(:chef) }
  let!(:other_chef) do
    create(:chef, id: 201, name: 'testuser2',
                  email: 'testuser2@example.com', password: 'testothrechef', password_confirmation: 'testothrechef')
  end

  before do
    sign_in chef
    visit "/yumyum/chefs/#{chef.id}/edit"
  end


    it '情報を更新した場合' do
      attach_file 'chef_image', "#{Rails.root}/spec/factories/sample_chef.jpg"
      fill_in 'chef_address', with: '兵庫県'
      fill_in 'chef_shop_name', with: "testshop"
      fill_in 'chef_shop_tel', with: "0000-00-0000"
      fill_in 'chef_shop_url', with: "#"
      fill_in 'chef_introduction', with: "こんにちは"
      click_button "プロフィール登録"
      expect(page).to have_content "プロフィールを更新しました"
      expect(current_path).to eq "/yumyum/chefs/#{chef.id}"
      expect(page).to have_content "testshop"
    end

    it 'アカウントを削除した場合', js: true do
      click_on 'アカウントを削除'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'アカウントを削除しました'
      visit "yumyum/chefs/#{chef.id}"
      expect(current_path).to eq new_yumyum_chef_path
    end

    it 'プロフィール編集のリンクはログインしたユーザ-idのみ表示されているか' do
      visit "/yumyum/chefs/#{chef.id}"
      expect(page).to have_link 'プロフィール編集'
      visit "/yumyum/chefs/#{other_chef.id}"
      expect(page).to have_no_link "プロフィール編集"
    end
end
