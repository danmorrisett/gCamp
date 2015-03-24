class MembershipsController < ApplicationController

  before_action :ensure_current_user  

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
      redirect_to project_memberships_path
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
    redirect_to project_memberships_path
  end

  private

  def membership_params
    params.require(:membership).permit(:role, :project_id, :user_id)
  end

end
