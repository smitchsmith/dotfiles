class CatRentalRequestsController < ApplicationController
  before_filter :require_current_user!, only: [:approve, :deny]

  def new
    @cat = Cat.find(params[:id])
    render :new
  end

  def create
    @request = CatRentalRequest.new(params[:cat_rental_request])
    unless @request.save
      flash[:errors] ||= []
      flash[:errors] << @request.errors.full_messages.to_sentence
    end
    redirect_to Cat.find(params[:id])
  end

  def approve
    @request = CatRentalRequest.find(params[:id])
    @cat = Cat.find(@request.cat_id)


    if current_user.cats.include?(@cat)
      @request.approve!
    else
      flash[:errors] = "Cat doesn't belong to you!"
    end
    redirect_to @cat
  end

  def deny
    @request = CatRentalRequest.find(params[:id])
    @cat = Cat.find(@request.cat_id)

    if current_user.cats.include?(@cat)
      @request.deny!
    else
      flash[:errors] = "Cat doesn't belong to you!"
    end
    redirect_to @cat
  end
end
