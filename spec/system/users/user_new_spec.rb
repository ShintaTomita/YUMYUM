# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ユーザー新規登録の有効性', type: :system do
  before do
    visit new_yumyum_user_path
  end

  describe '新規登録機能について' do
    it '項目を全て入力した場合' do
      fill_in 'user_name', with: 'testuser2'
      fill_in 'user_email', with: 'testuser@example'
      fill_in 'user_password', with: 'testuser2'
      fill_in 'user_password_confirmation', with: 'testuser2'
      click_on 'アカウント登録'
      expect(current_path).to eq "/yumyum/users/#{User.ids.first}/edit"
      sign_in User
    end

    it 'パスワードが一致しない場合' do
      fill_in 'user_name', with: 'testuser2'
      fill_in 'user_email', with: 'testuser@example'
      fill_in 'user_password', with: 'testuser2'
      fill_in 'user_password_confirmation', with: 'test'
      click_on 'アカウント登録'
      expect(page).to have_content 'メールアドレス、パスワードが間違っています'
    end
  end
end
