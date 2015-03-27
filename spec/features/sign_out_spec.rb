require 'rails_helper'


  feature 'Users should be able to sign out' do

      before :each do
        user = create_user
        sign_in_user(user)
      end

   it 'should be able to click on the sign out button' do

       visit root_path
       click_on 'Sign Out'
       within '.alert-success' do
           expect(page).to have_content 'You have successfully logged out'
         end
         expect(current_path).to eq(root_path)
       end

  end
