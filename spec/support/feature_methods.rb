def sign_in_user(user)
  visit root_path
  click_link 'Sign In'
  fill_in :email, with: user.email
  fill_in :password, with: user.password
  click_button 'Sign In'
end
