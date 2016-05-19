class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(params[:user])
    fc = user.friend_circles.new(title: "Your first friend circle!")
    post = user.posts.new(params[:post])
    links = post.links.new(params[:link].values)
    if user.save
      log_in!(user)
      redirect_to user_url(user)
    else
      flash[:errors] = user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.includes(:friend_circles).find(params[:id])
  end

  def reset_password_request
    user = User.find_by_email(params[:user][:email])
    user.create_reset_token!
    user.send_forgot_pwd_email
    redirect_to root_url
  end

  def reset_password_page
  end

  def reset_password
    user = User.find_by_reset_token(params[:reset_token])
    if user.update_attributes(params[:user])
      flash[:notices] = "Password Reset!"
      log_in!(user)
      redirect_to user_url(user)
    else
      flash[:errors] = user.errors.full_messages
      redirect_to new_session_url
    end
  end

end
