class FriendCirclesController < ApplicationController

  def new
    @user = User.find(params[:id])
    @friend_circle = FriendCircle.new
    @users = User.all
  end

  def create
    user = User.find(params[:id])
    fc = FriendCircle.new(user_id: user.id, title: params[:friend_circle][:title])
    fc.friend_ids = params[:user][:friend_ids]

    if fc.save
      redirect_to user_url(user)
    else
      flash[:errors] = fc.errors.full_messages
      render :new
    end
  end

  def edit
    @friend_circle = FriendCircle.find(params[:id])
    @user = @friend_circle.owner
    @users = User.all
  end

  def update
    fc = FriendCircle.find(params[:id])
    fc.title = params[:friend_circle][:title]
    fc.friend_ids = params[:user][:friend_ids]

    if fc.save
      redirect_to user_url(fc.owner)
    else
      flash[:errors] = fc.errors.full_messages
      render :edit
    end
  end

  def destroy

  end

  def index

  end

  def show

  end

end
