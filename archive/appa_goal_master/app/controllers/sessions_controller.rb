class SessionsController < ApplicationController

  def new
    redirect_to user_url(current_user) if current_user
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if user
      session[:token] = user.reset_token!
      redirect_to user_url(user)
    else
      flash.now[:errors] = "Invalid login!"
      render :new
    end
  end

  def destroy
    current_user.reset_token!
    session[:token] = nil
    redirect_to new_session_url
  end

end
