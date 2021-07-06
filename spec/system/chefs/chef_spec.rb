# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'before_actionメソッドの有効性について', type: :system do
  let!(:chef) { create(:chef) }
  let!(:other_chef) do
    create(:chef, id: 201, name: 'testuser2',
                  email: 'testuser2@example.com', password: 'testothrechef', password_confirmation: 'testothrechef')
  end

  before do
    visit yumyum_root_path
  end

  it 'ログインしていないユーザーが他ユーザーのページへアクセスした場合' do
    visit "yumyum/chefs/#{chef.id}/edit"
    expect(current_path).to eq new_chef_session_path
  end

  it 'ログインしているユーザーが他ユーザーのeditページへアクセスした場合' do
    sign_in chef
    visit "/yumyum/chefs/#{other_chef.id}/edit"
    expect(page).to have_content '権限がありません'
    expect(current_path).to eq yumyum_root_path
  end
end
