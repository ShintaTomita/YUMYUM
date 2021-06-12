require "rails_helper"

RSpec.feature "authenticate,ensure_correct_user,forbid_login_userの有効性について", type: :feature do
  given!(:user) { create(:user) }
  given!(:other_user) { create(:user, id: 101, name: "testotheruser",
                                      email: "testotheruser@example", password: "testotheruser") }

  background do
    visit yumyum_root_path
  end

  scenario "ログインしていないユーザーが他ユーザーのページへアクセスした場合"do
    visit "/yumyum/users/#{user.id}"
    expect(current_path).to eq new_user_session_path
   end

  scenario "ログインしているユーザーが他ユーザーのページへアクセスした場合" do
    sign_in user
    visit "/yumyum/users/#{other_user.id}/edit"
    expect(page).to have_content "権限がありません"
    expect(current_path).to eq yumyum_root_path
  end

  scenario "ログインしているユーザーがログインページへアクセスした場合" do
    sign_in user
    visit new_yumyum_user_path
    expect(page).to have_content "ログインしています"
    expect(current_path).to eq yumyum_root_path
  end
end
