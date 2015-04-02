require 'rails_helper'

describe TasksController do
  describe 'GET #index' do
    describe 'Permissions' do


    end
  end










      describe 'Delete #destroy' do
        it 'deletes a task' do
      User.destroy_all
      user = User.create!(first_name: 'Bob', last_name: 'Ross', email: 'bob@Ross.com', password: 'bob', admin: false)
      session[:user_id] = user.id
      project = Project.create!(name: 'Happy Trees')
      Membership.create!(user_id: user.id, project_id: project.id, role: 1)
      task = project.tasks.create(description: "Pop lock it", due_date: '2015-04-20')

      expect {
        patch :update, project_id: project.id, id: task.id, task: { description: "Pop lock and drop it", due_date: '2015-04-20' }
      }.to change { task.reload.description }.from("Pop lock it").to("Pop lock and drop it")

      expect(flash[:notice]).to eq "Task was successfully updated"
      expect(response).to redirect_to project_task_path(project, task)


    end
  end
end
