class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_credentials(params[:user][:un_or_email], params[:user][:password])
    if user
      sign_in!(user)
      prev_url_fragment = session[:prev_url_fragment]
      redirect_to (prev_url_fragment ? page_url(prev_url_fragment) : user_url(user))
    else
      redirect_to new_session_url
    end
  end

  def destroy
    sign_out!(current_user)
    redirect_to new_session_url
  end
end
