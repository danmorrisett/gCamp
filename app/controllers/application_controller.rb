class ApplicationController < ActionController::Base

  def current_user
    if session[:user_id].present?
      User.find_by(id: session[:user_id])
    end
  end

  protect_from_forgery with: :exception


  helper_method :current_user



  def ensure_current_user
    unless current_user
      flash[:error] = 'You must sign in'
      store_location
      redirect_to sign_in_path
    end
  end

  def store_location
      session[:user_return_to] = request.fullpath
  end

  def ensure_membership
    unless current_user.memberships.find_by(:project_id => @project.id) || current_user.admin
      flash[:error] = 'You do not have access to that project'
      redirect_to projects_path
    end
  end


end
