class PostsController < ApplicationController
  def new
    @user = User.find(params[:id])
    @friend_circles = FriendCircle.all
  end

  def create
    @user = User.find(params[:id])
    post = Post.new(params[:post])
    post.links.new(params[:link].values)
    post.friend_circle_ids = params[:friend_circle_ids]

    if post.save
      redirect_to user_url(@user)
    else
      flash[:errors] = post.errors.full_messages
      redirect_to :new
    end
  end

  def index
  end
end
