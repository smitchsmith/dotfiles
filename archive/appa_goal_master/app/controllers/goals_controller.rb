class GoalsController < ApplicationController

  def new
  end

  def create
    goal = Goal.new(params[:goal])
    goal.user_id = current_user.id
    if goal.save
      redirect_to user_url(current_user)
    else
      flash.now[:errors] = goal.errors.full_messages
      render :new
    end
  end

  def update
    goal = Goal.find(params[:id])
    goal.completed = true
    if goal.save
      redirect_to user_url(current_user)
    else
      flash[:errors] = goal.errors.full_messages
      redirect_to user_url(current_user)
    end
  end

  def fancy_destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to users_url
  end


end



# index


# ADN  [dropdown of goals] [Delete Goal]  [Delete User]