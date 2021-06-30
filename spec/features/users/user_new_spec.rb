# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'ユーザー新規登録の有効性', type: :feature do
  background do
    visit new_yumyum_user_path
  end

  scenario '新規登録ができるか' do
    fill_in 'user_name', with: 'testuser2'
    fill_in 'user_email', with: 'testuser@example'
    fill_in 'user_password', with: 'testuser2'
    fill_in 'user_password_confirmation', with: 'testuser2'
    click_on 'アカウント登録'
    expect(current_path).to eq "/yumyum/users/#{User.ids.first}/edit"
    sign_in User
  end

  scenario 'パスワードが一致しない場合' do
    fill_in 'user_name', with: 'testuser2'
    fill_in 'user_email', with: 'testuser@example'
    fill_in 'user_password', with: 'testuser2'
    fill_in 'user_password_confirmation', with: 'test'
    click_on 'アカウント登録'
    expect(page).to have_content 'メールアドレス、パスワードが間違っています'
  end
end
