class TasksController < ApplicationController

  before_action :ensure_current_user
  before_action :find_and_set_project
  before_action :ensure_membership


  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @tasks = @project.tasks

  end

  def new
    @task = @project.tasks.new
  end

  def create
    @task = @project.tasks.new(tasks_params)
      if @task.save
        flash[:notice] = 'Task was successfully created.'
        redirect_to project_task_path(@project, @task)
      else
        render :new
      end
  end

  def show
    @task = @project.tasks.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @task = @project.tasks.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(tasks_params)
      redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to project_tasks_path
  end

    private

    def ensure_membership
      unless Membership.where(project_id: @project.id).include?(current_user.memberships.find_by(:project_id => @project.id))
        flash[:error] = 'You do not have access to that project'
        redirect_to projects_path
      end
    end

    def find_and_set_project
      @project = Project.find(params[:project_id])
    end

    def tasks_params
      params.require(:task).permit(:description, :complete, :due_date)
    end

end
