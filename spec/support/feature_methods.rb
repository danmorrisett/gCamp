def sign_in_user
  user = User.new(first_name: 'The', last_name: 'One', email: 'The@one.com', password: '123')
  user.save!
  visit root_path
  click_link 'Sign In'
  fill_in :email, with: user.email
  fill_in :password, with: '123'
  click_button 'Sign In'
end 
