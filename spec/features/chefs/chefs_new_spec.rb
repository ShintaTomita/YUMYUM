# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'シェフ新規登録の有効性', type: :feature do
  background do
    visit new_yumyum_chef_path
  end

  scenario '新規登録ができるか？' do
    fill_in 'chef_name', with: 'testchef'
    fill_in 'chef_email', with: 'testchef@example.com'
    fill_in 'chef_password', with: 'testchef'
    fill_in 'chef_password_confirmation', with: 'testchef'
    click_on 'アカウント登録'
    expect(current_path).to eq "/yumyum/chefs/#{Chef.ids.first}/edit"
    sign_in Chef
  end

  scenario 'パスワードが一致しない場合' do
    fill_in 'chef_name', with: 'testchef'
    fill_in 'chef_email', with: 'testchef@example.com'
    fill_in 'chef_password', with: 'testchef'
    fill_in 'chef_password_confirmation', with: ''
    click_on 'アカウント登録'
    expect(page).to have_content 'メールアドレス、パスワードが間違っています'
  end
end
