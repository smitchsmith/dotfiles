class StaticsController < ApplicationController
  def index
    render :index
    session[:had_tour] = true
  end
end
