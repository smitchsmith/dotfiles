class CatsController < ApplicationController
  before_filter :require_current_user!, except: [:index, :show]

  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
    @cat_rental_requests = @cat.cat_rental_requests
  end

  def new
    @cat = Cat.new
  end

  def create
    attrs = params[:cat]
    attrs[:user_id] = self.current_user.id
    @cat = Cat.new(attrs)
    if @cat.save
      redirect_to @cat
    else
      flash[:errors] ||= []
      flash[:errors] << @cat.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    redirect_to cats_url if current_user != @cat.owner
  end

  def update
    redirect_to cats_url if current_user != cat.owner
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(params[:cat])
      redirect_to @cat
    else
      flash[:errors] ||= []
      flash[:errors] << @cat.errors.full_messages.to_sentence
      render :edit
    end
  end
end
