class ProjectsController < ApplicationController

  before_action :ensure_current_user


  def index
    @projects = Project.all
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
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      flash[:notice] = 'Project was successfully updated'
      redirect_to project_path
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to projects_path, notice: "Project was successfully deleted"
  end

  private
  def project_params
    params.require(:project).permit(:name)
  end

end
