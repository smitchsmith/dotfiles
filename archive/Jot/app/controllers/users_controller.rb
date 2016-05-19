class UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(params[:user])

    if user.save
      sign_in!(user)
      # UserMailer.welcome(user).deliver!
      redirect_to user_url(user)
    else
      flash[:errors] = user.errors.full_messages
      redirect_to :new
    end

  end

  def show
    @user = User.find(params[:id])
    @private_pages = @user.pages.where(is_public: false)
    @public_pages = @user.pages.where(is_public: true)
  end

  # def update
  #   user = User.find(params[:id])
  #   user.update_attributes!(params[:user])
  #   redirect_to user_url(user)
  # end

end
