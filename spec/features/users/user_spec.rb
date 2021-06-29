# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'before_actionメソッドの有効性について', type: :feature do
  given!(:user) { create(:user) }
  given!(:other_user) do
    create(:user, id: 101, name: 'testotheruser',
                  email: 'testotheruser@example', password: 'testotheruser')
  end

  background do
    visit yumyum_root_path
  end

  scenario 'ログインしていないユーザーが他ユーザーのページへアクセスした場合' do
    visit "/yumyum/users/#{user.id}"
    expect(current_path).to eq new_user_session_path
  end

  scenario 'ログインしているユーザーが他ユーザーのページへアクセスした場合' do
    sign_in user
    visit "/yumyum/users/#{other_user.id}/edit"
    expect(page).to have_content '権限がありません'
    expect(current_path).to eq yumyum_root_path
  end

  scenario 'ログインしているユーザーがログインページへアクセスした場合' do
    sign_in user
    visit new_yumyum_user_path
    expect(page).to have_content 'ログインしています'
    expect(current_path).to eq yumyum_root_path
  end

  scenario '存在しないidのページへアクセスした場合' do
    visit '/yumyum/chefs/204'
    expect(page).to have_content '存在しないページです'
    expect(current_path).to eq new_yumyum_chef_path
  end
end
