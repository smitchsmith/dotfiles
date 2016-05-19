class UsersController < ApplicationController
  def index
    render :json => User.all
  end

  def create
    user = User.new(params[:user])
    if user.save
      render :json => user
    else
      render :json => user.errors.full_messages, :status => :unprocessable_entity
    end
  end

  def show
    id = params["id"]
    user = User.find(id)
    if user
      render :json => user
    else
      render :text => "User not found"
    end
  end

  def update
    id = params["id"]
    user = User.find(id)
    if user.update_attributes(params["user"])
      render :json => user
    else
      render :json => user.errors.full_messages
    end
  end

  def destroy
    id = params["id"]
    user = User.find(id)
    user.delete
    render :json => user
  end
end
