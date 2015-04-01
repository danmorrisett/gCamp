require 'rails_helper'

  feature 'Sign in as an existing user' do
    scenario 'can log in to see tasks, projects, and user' do
      user = User.new(first_name: 'Mo', last_name: 'Ali', email: 'MoAli@gmail.com', password:'123')
      user.save!
      Project.create!(name: '2')

      visit root_path
      click_link 'Sign In'

      expect(current_path).to eq '/sign-in'
      expect(page).to have_content 'Sign into gCamp'

      fill_in :email, with: user.email
      fill_in :password, with: '123'
      click_button 'Sign In'

      expect(page).to have_content "Projects"

      expect(current_path).to eq "/projects"
      expect(page).to have_content 'You have signed in successfully'
      expect(page).to have_content 'New Project'

      user.destroy!
    end

    scenario 'guest sees validation message when trying to sign in' do

      visit root_path

      click_link 'Sign In'

      expect(current_path).to eq '/sign-in'
      expect(page).to have_content 'Sign into gCamp'

      click_button 'Sign In'

      expect(current_path).to eq '/sign-in'
      expect(page).to have_content 'Email / Password combination is invalid'
    end
  end
