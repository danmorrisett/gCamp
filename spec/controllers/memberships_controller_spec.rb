require 'rails_helper'

describe MembershipsController do
  describe 'PATCH #update' do
    it 'should redirect a member to projects patch' do
      user = create_user
      project = create_project
      membership = create_membership(user_id: user.id, project_id: project.id, role: 0)
      session[:user_id] = user.id

      expect{
        patch :update, project_id: project.id, id: membership.id, membership: {role: 1}
      }.to_not change { membership.reload.role}
      expect(response).to redirect_to projects_path
      expect(flash[:error]).to eq 'You do not have access'
    end

  end
end
