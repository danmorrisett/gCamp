require 'rails_helper'

describe MembershipsController do


  describe 'GET #index' do
    it 'assigns a new membership for a project' do
      user = create_user(admin: false)
      project = create_project
      membership = create_membership(project, user, role: 0)
      session[:user_id] = user.id

      get :index, project_id: project.id

      expect(assigns(:membership)).to be_a_new(Membership)
    end
  end

  describe 'POST #create' do
    describe "on success" do
      it "Creates a new membership" do
        user = create_user(admin: true)
        project = create_project
        session[:user_id] = user.id

        expect{
        post :create, project_id: project.id, membership: { project_id: project.id, user_id: user.id, role: 1 }
        }.to change { Membership.all.count }.by(1)

        membership = Membership.last
        expect(membership.user_id).to eq user.id

        expect(response).to redirect_to project_memberships_path(project)

      end
    end
  end

  describe 'PATCH #update' do
    it 'should redirect a member to projects patch' do
      user = create_user(admin: false)
      project = create_project
      membership = create_membership(project, user, role: 0)
      session[:user_id] = user.id

      expect{
        patch :update, project_id: project.id, id: membership.id, membership: {role: 1}
      }.to_not change { membership.reload.role}
      expect(response).to redirect_to projects_path
      expect(flash[:error]).to eq 'You do not have access'
    end
  end


  describe 'DELETE #destroy' do
    describe "on success" do
    it "deletes a membership" do
      project = create_project
      user = create_user(email: "HappyTrees@gmail.com")
      membership = create_membership(project, user)
      session[:user_id] = user.id

      delete :destroy, project_id: project.id, id: membership.id

      expect(Membership.all).to eq []
      end
    end
  end
end
