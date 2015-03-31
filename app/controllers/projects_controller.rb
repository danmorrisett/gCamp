class ProjectsController < ApplicationController

  before_action :ensure_current_user
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :ensure_membership, only: [:show, :edit, :update, :destroy]
  before_action :ensure_owner, only: [:update, :edit, :destroy]

  def index
    @projects = current_user.projects

  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @project.memberships.create(user_id: current_user.id, role: 1)
      flash[:notice] = 'Project was successfully created.'
      redirect_to project_tasks_path(@project)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @project.update(project_params)
      flash[:notice] = 'Project was successfully updated'
      redirect_to project_path
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project was successfully deleted"
  end

  private

  def ensure_owner
      unless current_user.project_owner(@project)
        flash[:error] = 'You do not have access'
        redirect_to project_path(@project)
      end
    end


  def set_project
    @project = Project.find(params[:id])
  end

  def ensure_membership
    if !current_user.memberships.find_by(:project_id => @project.id)
      flash[:error] = 'You do not have access to that project'
      redirect_to projects_path
    end
  end

  def project_params
    params.require(:project).permit(:name)
  end

end
