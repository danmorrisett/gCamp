require 'rails_helper'

  feature 'Users should be able to sign out' do

   it 'should be able to click on the sign out button' do

       sign_in_user

       visit root_path
       click_on 'Sign Out'
       within '.alert-success' do
           expect(page).to have_content 'You have successfully logged out'
         end
         expect(current_path).to eq(root_path)
       end

  end
