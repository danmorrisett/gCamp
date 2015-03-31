class MembershipsController < ApplicationController

  before_action :set_project
  before_action :ensure_membership, only: [:index]
  before_action :ensure_current_user
  before_action :ensure_current_user_member, only: [:destroy]

  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @membership = @project.memberships.new
  end

  def create
    @membership = @project.memberships.new(membership_params.merge(role: params[:membership][:role].to_i))
    if @membership.save
      flash[:notice] = "#{@membership.user.full_name} was successfully added"
      redirect_to project_memberships_path(@project)
    else
      render :index
    end
  end

  def edit
    @membership = Membership.find(params[:id])
  end

  def update
    @membership = Membership.find(params[:id])
    if @membership.update(membership_params.merge(role: params[:membership][:role].to_i))
      flash[:notice] = "#{@membership.user.full_name} was successfully updated"
      redirect_to project_memberships_path(@project)
    else
      render :index
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    flash[:notice] = "#{@membership.user.full_name} was removed from project"
    redirect_to projects_path
  end


  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def ensure_membership
    unless Membership.where(project_id: @project.id).include?(current_user.memberships.find_by(:project_id => @project.id))
      flash[:error] = 'You do not have access to that project'
      redirect_to projects_path
    end
  end

  def membership_params
    params.require(:membership).permit(:role, :project_id, :user_id)
  end

  def ensure_current_user_member
    unless current_user.id == @project.memberships.where(user_id: current_user.id)
      flash[:error] = "You do not have access"
      redirect_to projects_path
    end
  end

end
