class CurrentUsersController < ApplicationController
  def show
    render json: current_user.to_json(include: :favorites)
  end
end
