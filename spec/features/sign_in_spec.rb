require 'rails_helper'

  feature 'Sign In' do

    scenario 'User can sign in' do
      user = User.create(first_name: "Dan", last_name: "M", email: "DM@gmail.com", password:"123")
      visit root_path
      click_on 'Sign In'
      expect(page).to have_content("Sign into gCamp")
      fill_in 'Email', with: 'DM@gmail.com'
      fill_in 'Password', with: '123'

      within("form") {click_on "Sign In"}
      expect(page).to have_content("You have signed in successfully")
      expect(page).to have_content("Dan M")
      expect(current_path).to eq '/'
    end
  end
