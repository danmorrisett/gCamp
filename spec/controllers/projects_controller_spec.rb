require 'rails_helper'

describe ProjectsController do
  describe 'GET #index' do
    describe 'Permissions' do

      it 'redirects a visitor to sign in path' do

        get :index

        expect(response).to redirect_to sign_in_path
      end
    end
  end

  describe 'GET #new' do
    describe 'Permissions' do
      it 'assigns a new project' do
        User.destroy_all
        Project.destroy_all
        user = User.create!(first_name: "Bob", last_name: "Ross", email: "BobR@gmail.com", password: "123", admin: "false")
        session[:user_id] = user.id
        project = Project.create!(name: "Happy")

        get :new

        expect(assigns(:project)).to be_a_new(Project)
      end
    end
  end

  describe 'POST #create' do
    describe 'Permissions' do
      it 'redirects a visitor to sign in path' do

        User.destroy_all
        Project.destroy_all
        user = User.create!(first_name: "Bob", last_name: "Ross", email: "BobR@gmail.com", password: "123", admin: "false")
        session[:user_id] = user.id

        expect {
          post :create, project: { name: 'Happy' }
        }.to change { Project.all.count }.by(1)

        project = Project.last
        expect(project.name).to eq "Happy"
        expect(response).to redirect_to project_tasks_path(project)
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
        User.destroy_all
        user = User.create!(first_name: "Bob", last_name: "Ross", email: "BobR@gmail.com", password: "123", admin: "false")
        session[:user_id] = user.id
        project = Project.create!(name: "Happy")
        Membership.create!(user_id: user.id, project_id: project.id, role: 1)

        expect {
          delete :destroy, id: project.id
        }.to change { Project.all.count }.by(-1)


      end
      it 'redirects a non-member to projects path' do
      end
      it 'redirects a member to projects path' do
      end

    end
  end
end
