require 'rails_helper'

feature 'Sign up as a new user' do
  scenario 'can visit root path and sign up as a new user' do
    visit root_path

    click_link 'Sign Up'

    expect(current_path).to eq '/sign-up'
    expect(page).to have_content 'Sign up for gCamp!'
    fill_in :user_first_name, with: 'Stevie'
    fill_in :user_last_name, with: 'Wonder'
    fill_in :user_email, with: 'Stevie@Wonder.com'
    fill_in :user_password, with: '123'
    fill_in :user_password_confirmation, with: '123'

    click_button 'Sign Up'

    expect(current_path).to eq root_path
    expect(page).to have_content 'You have successfully signed up'
  end

  scenario 'guest sees validation message when trying to sign up' do

    visit root_path

    click_link 'Sign Up'

    expect(current_path).to eq '/sign-up'
    expect(page).to have_content 'Sign up for gCamp!'

    click_button 'Sign Up'

    expect(current_path).to eq '/sign-up'
    expect(page).to have_content 'First name can\'t be blank'
    expect(page).to have_content 'Last name can\'t be blank'
    expect(page).to have_content 'Email can\'t be blank'
    expect(page).to have_content 'Password can\'t be blank'
  end
end
