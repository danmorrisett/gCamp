class MembershipsController < ApplicationController
  before_action :ensure_current_user

  before_action :set_project
  before_action :set_membership, only: [:edit, :update, :destroy]
  before_action :ensure_membership, only: [:index]
  before_action :ensure_atleast_1_owner, only: [:update, :destroy]
  before_action :ensure_current_user_is_owner, only: [:update]

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
  end

  def update
    if @membership.update(membership_params.merge(role: params[:membership][:role].to_i))
      flash[:notice] = "#{@membership.user.full_name} was successfully updated"
      redirect_to project_memberships_path(@project)
    else
      render :index
    end
  end

  def destroy
    if @membership.user == current_user || Membership.where(role: 1, user_id: current_user.id, project_id: @project.id).present? || current_user.admin
    @membership.destroy
    flash[:notice] = "#{@membership.user.full_name} was removed from project"
    redirect_to projects_path
  else
    flash[:notice] = "You do not have access"
    redirect_to project_path(@project)
  end
  end


  private

  def ensure_atleast_1_owner
    if @project.memberships.where(role: 1).count <= 1 && @membership.role == "owner"
      flash[:error] = "Projects must have atleast one owner"
      redirect_to project_memberships_path(@project)
    end
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_membership
    @membership = Membership.find(params[:id])
  end


  def membership_params
    params.require(:membership).permit(:role, :project_id, :user_id)
  end

  def ensure_current_user_is_owner
    if !current_user.project_owner(@project)
      flash[:error] = "You do not have access"
      redirect_to projects_path
    end
  end

end
