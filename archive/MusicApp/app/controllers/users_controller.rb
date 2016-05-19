class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    user = User.new(params[:user])
    user.save!
    user.send_activation_email
    self.current_user = user
    redirect_to root_url
  end

  def activate
    token = params[:token]
    user = User.find_by_activation_token(token)
    redirect_to root_url
  end

end
