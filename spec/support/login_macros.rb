module LoginMacros
  def set_user_session(user)
    session[:user_id] = user.id
  end

  def sign_in(user)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email # プレーンテキストの探索を行っている
    fill_in 'Password', with: user.password # プレーンテキストの探索を行って、そこに入力を行っている
    click_button 'Log In'
  end
end
