class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(params[:user])
    if user.save
      session[:token] = user.reset_token!
      redirect_to user_url(user)
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def show
    redirect_to new_session_url unless current_user
    @user = User.find(params[:id])
    @goals = current_user == @user ? @user.goals : @user.public_goals
  end

  def index
    @users = User.all
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url
  end

end
