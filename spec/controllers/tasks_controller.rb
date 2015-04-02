require 'rails_helper'

describe TasksController do
  describe 'GET #index' do
    it 'Lists all tasks' do
      User.destroy_all
      user = create_user
      session[:user_id] = user.id
      project = create_project
      task = create_task(project_id: project.id)

      get :index, project_id: project.id

      expect(Task.all).to include(Task.last)

    end
  end

  describe 'GET #new' do
    it 'Creates a new task' do
      User.destroy_all
      user = create_user
      session[:user_id] = user.id
      project = create_project

      task = Task.new

      get :new, project_id: project.id

      expect(task).to be_a_new(Task)
    end
  end

  describe 'POST #create' do
    it 'Creates a new task' do
      User.destroy_all
      user = create_user
      session[:user_id] = user.id
      project = create_project


      expect {
      post :create, project_id: project.id, task: { description: "Happy Tree"}
    }.to change { Task.count }.by(1)

      expect(Task.last.description).to eq "Happy Tree"
      expect(response.status).to eq(302)
    end
  end

  describe 'GET #show' do
    it 'Able to see the tasks of your projects' do
      User.destroy_all
      user = create_user
      session[:user_id] = user.id
      project = create_project
      task = create_task(project_id: project.id)

      get :show, project_id: project.id, id: task.id

      expect(assigns(:task)).to be_a(Task)

    end
  end

  describe 'GET #edit' do
    it 'Gets a edit form for the task' do
      User.destroy_all
      user = create_user
      session[:user_id] = user.id
      project = create_project
      task = create_task(project_id: project.id)

      get :edit, project_id: project.id, id: task.id

      expect(assigns(:task)).to be_a(Task)
      expect(response).to render_template :edit

    end
  end

  describe 'PATCH #update' do
    it 'Able to update the tasks of your projects' do
      User.destroy_all
      user = create_user
      session[:user_id] = user.id
      project = create_project
      task = create_task(project_id: project.id)
      membership = create_membership(project, user, role: 0)

    expect {
      patch :update, project_id: project.id, id: task.id, task: {description: "More Power", due_date: '2015/4/20'}
    }.to change { task.reload.description }.from("New Task").to("More Power")

    task = Task.last



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
