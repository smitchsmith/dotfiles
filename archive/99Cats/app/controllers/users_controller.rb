class UsersController < ApplicationController
  before_filter :require_current_user!, only: :show

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      self.current_user = @user
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      redirect_to cats_url
    end
  end

  def show
    if params.include?(:id) && current_user.id == params[:id].to_i
      @user = current_user
      @cats = @user.cats
    else
      redirect_to user_url(current_user)
    end
  end
end