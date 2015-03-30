class AuthenticationController < StaticController

  def destroy
    session.clear
    redirect_to root_path flash[:notice] = 'You have successfully logged out'
  end

  def new

  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'You have signed in successfully'
      redirect_to root_path
    else
      @auth_error = 'Email / Password combination is invalid'
      render :new
    end
  end
  # def create
    # user = User.find_by(email: params[:email])
    # if user && user.authenticate(params[:password])
    #   session[:user_id] = user.id
    #   flash[:notice] = 'You have signed in successfully'
    #   redirect_to root_path
    # else
    #   @authentication_error = 'ERROR!'
    #   render :new
    # end
  # end


end
