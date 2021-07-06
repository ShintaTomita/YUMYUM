# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'トップページの有効性について', type: :feature do
  background do
    visit yumyum_root_path
  end

  scenario 'リンクは正しいか' do
    expect(page).to have_link 'YUMYUM', href: yumyum_root_path
    expect(page).to have_link '新規登録', href: new_yumyum_user_path
    expect(page).to have_link 'ログイン', href: new_user_session_path
    expect(page).to have_link 'ユーザー新規登録', href: new_yumyum_user_path
  end

  context 'ログインした場合' do
    given!(:user) { create(:user) }
    background do
      sign_in user
      visit yumyum_root_path
    end
    scenario 'マイページへのリンクは有効か？' do
      click_on 'マイページ'
      expect(current_path).to eq "/yumyum/users/#{user.id}"
    end

    scenario 'ログアウトは有効か' do
      click_on 'ログアウト'
      expect(current_path).to eq destroy_user_session_path
      expect(page).to have_no_link 'ログアウト'
    end
  end
end
