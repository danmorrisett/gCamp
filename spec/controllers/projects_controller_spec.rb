require 'rails_helper'

describe ProjectsController do
  describe 'GET #index' do
    describe 'Permissions' do
        session[:user_id] = user.id

      it 'redirects a visitor to sign in path' do

        get :index
      end
    end
  end
  describe 'GET #new' do
    describe 'Permissions' do
      it 'redirects a visitor to sign in path' do

        get :new
        expect(response).to redirect_to sign_in_path
      end
    end
  end
  describe 'POST #create' do
    describe 'Permissions' do
      it 'redirects a visitor to sign in path' do

        post :create
        expect(response).to redirect_to sign_in_path
      end
    end
  end
  describe 'GET #show' do
    describe 'Permissions' do
      it 'redirects a visitor to sign in path' do
        project = create_project

        get :show, id: project.id
        expect(response).to redirect_to sign_in_path
      end
      it 'redirects a non member to projects path' do
      end
    end
  end
  describe 'GET #edit' do
    describe 'Permissions' do
      it 'redirects a visitor to sign in path' do
        project = create_project

        get :edit, id: project.id
        expect(response).to redirect_to sign_in_path
      end
      it 'redirects a non-member to projects path' do
      end
      it 'redirects a member to projects path' do
      end
    end
  end
  describe 'patch #update' do
    describe 'Permissions' do
      it 'redirects a visitor to sign in path' do
        project = create_project
        patch :update, id: project.id
        expect(response).to redirect_to sign_in_path
      end
      it 'redirects a non-member to projects path' do
      end
      it 'redirects a member to projects path' do
      end
    end
  end
  describe 'DELETE #destroy' do
    describe 'Permissions' do
      it 'redirects a visitor to sign in path' do
        project = create_project

        delete :destroy, id: project.id
        expect(response).to redirect_to sign_in_path
      end
      it 'redirects a non-member to projects path' do
      end
      it 'redirects a member to projects path' do
      end

    end
  end
end
