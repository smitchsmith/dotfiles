class PasswordResetsController < ApplicationController

  def create
    user = User.find(params[:id])
    user.reset_password_reset!
    UserMailer.password_reset(user).deliver!
    redirect_to user_url(user)
  end

  def edit
    @user = User.find_by_password_reset(params[:token])
    redirect_to user_url(1) if @user.nil? # root
  end

  def update
    user = User.find_by_password_reset(params[:token])
    redirect_to user_url(1) if user.nil? # root

    if params[:password1] == params[:password2]
      user.password = params[:password1]
      user.password_reset = nil
      user.save!
      redirect_to user_url(user)
    else
      flash[:errors] = "Passwords don't match!"
      redirect_to password_reset_url(user.password_reset)
    end
  end

end
