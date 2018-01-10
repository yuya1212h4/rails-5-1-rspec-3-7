require 'rails_helper'

feature 'User management' do
  # 新しいユーザーを追加する
  scenario "adds a new user", js: true do
    admin = create(:admin)
    sign_in admin

    visit root_path
    expect{
      click_link 'Users'
      click_link 'New User'
      fill_in 'Email', with: 'newuser@exmaple.com'
      find('#password').fill_in 'Password', with: 'secret123' # 要素の探索を行っている 要素が被るために、findメソッドを使っている
      find('#password_confirmation').fill_in 'Password confirmation', with: 'secret123'
      click_button 'Create User'
    }.to change(User, :count).by(1)
    # save_and_open_page デバッグ用のメソッド
    expect(current_path).to eq users_path
    expect(page).to have_content 'New user created'
    within 'h1' do
      expect(page).to have_content 'Users'
    end
    expect(page). to have_content 'newuser@exmaple.com'
  end
end
