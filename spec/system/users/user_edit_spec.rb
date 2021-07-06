# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ユーザー情報の編集,削除について', type: :system do
  let!(:user) { create(:user) }

  before do
    sign_in user
    visit "/yumyum/users/#{user.id}/edit"
  end

  describe 'プロフィールの編集' do
    it 'プロフィールを更新した場合' do
      select '30代'
      choose 'user_sex_女性'
      click_on 'プロフィール登録'
      expect(page).to have_content 'プロフィールを更新しました'
      expect(current_path).to eq yumyum_root_path
      visit "yumyum/users/#{user.id}"
      expect(page).to have_content '30代'
      expect(page).to have_content '女性'
    end

    it 'アカウント削除をクリックした場合', js: true do
      click_on 'アカウントを削除'
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content 'アカウントを削除しました'
      visit "yumyum/users/#{user.id}"
      expect(current_path).to eq new_user_session_path
    end
  end
end
