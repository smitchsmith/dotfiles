class SubsController < ApplicationController

  before_filter :ensure_moderator, only: :edit

  def ensure_moderator
    sub = Sub.find(params[:id])
    redirect_to sub_url(sub) unless sub.moderator == current_user
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(params[:sub])
    @sub.links.new(params[:links].values)
    @sub.links.reject!{ |link| link.title.empty? }
    @sub.links.each { |link| link.submitter = current_user }
    @sub.moderator = current_user

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
    @subs = Sub.all
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update_attributes(params[:sub])
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    redirect_to subs_url
  end

end
