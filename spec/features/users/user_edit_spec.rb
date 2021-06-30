# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'ユーザー情報の編集,削除について', type: :feature do
  given!(:user) { create(:user) }

  background do
    sign_in user
    visit "/yumyum/users/#{user.id}/edit"
  end

  scenario '情報を更新した場合' do
    select '30代'
    choose 'user_sex_女性'
    click_on 'プロフィール登録'
    expect(page).to have_content 'プロフィールを更新しました'
    expect(current_path).to eq yumyum_root_path
    visit "yumyum/users/#{user.id}"
    expect(page).to have_content '30代'
    expect(page).to have_content '女性'
  end

  scenario 'アカウント削除をクリックした場合' do
    click_on 'アカウントを削除'
    expect(page).to have_content 'アカウントを削除しました'
    expect(current_path).to eq yumyum_root_path
    visit "yumyum/users/#{user.id}"
    expect(current_path).to eq new_user_session_path
  end
end
