# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'before_actionメソッドの有効性について', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) do
    create(:user, id: 101, name: 'testotheruser',
                  email: 'testotheruser@example', password: 'testotheruser')
  end

  before do
    visit yumyum_root_path
  end
  describe 'ユーザーメソッドについて' do
    it 'ログインしていないユーザーが他ユーザーのページへアクセスした場合' do
      visit "/yumyum/users/#{user.id}"
      expect(current_path).to eq new_user_session_path
    end

    it 'ログインしているユーザーが他ユーザーのページへアクセスした場合' do
      sign_in user
      visit "/yumyum/users/#{other_user.id}/edit"
      expect(page).to have_content '権限がありません'
      expect(current_path).to eq yumyum_root_path
    end

    it 'ログインしているユーザーがログインページへアクセスした場合' do
      sign_in user
      visit new_yumyum_user_path
      expect(page).to have_content 'ログインしています'
      expect(current_path).to eq yumyum_root_path
    end

    it '存在しないidのページへアクセスした場合' do
      visit '/yumyum/chefs/204'
      expect(page).to have_content '存在しないページです'
      expect(current_path).to eq new_yumyum_chef_path
    end
  end
end
