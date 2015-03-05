class ApplicationController < ActionController::Base
  def current_user
    if session[:user_id].present?
      User.find_by(id: session[:user_id])
    end
  end

  helper_method :current_user




  protect_from_forgery with: :exception
end
