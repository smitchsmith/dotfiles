class SessionsController < ApplicationController
  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if user.nil?
      flash.now[:errors] = "Credentials were wrong"
    else
      user.reset_session_token!
      self.current_user = user
      redirect_to user_url(user)
    end
  end

  def new
  end

  def destroy
    self.current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to cats_url
  end

end