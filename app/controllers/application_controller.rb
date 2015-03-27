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
      redirect_to sign_in_path
    end
  end


end
