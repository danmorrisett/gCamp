class AuthenticationController < StaticController


  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to session[:user_return_to] || projects_path
      flash[:notice] = 'You have signed in successfully'
    else
      @auth_error = 'Email / Password combination is invalid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:user_return_to] = nil
    redirect_to root_path flash[:notice] = 'You have successfully logged out'
  end

end
