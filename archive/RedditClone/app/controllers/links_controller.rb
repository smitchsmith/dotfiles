class LinksController < ApplicationController

  def new
    @link = Link.new
    @subs = Sub.all
  end

  def create
    @link = Link.new(params[:link])
    @link.user_id = current_user.id
    @link.sub_ids = params[:subs]

    if @link.save
      redirect_to link_url(@link)
    else
      flash.now[:errors] = @link.errors.full_messages
      render :new
    end
  end

  def show
    @link = Link.find(params[:id])
    @comments_by_parent_id = @link.comments_by_parent_id
  end

  def edit
    @link = Link.find(params[:id])
    @subs = Sub.all
  end

  def update
    @link = Link.find(params[:id])
    @link.sub_ids = params[:subs]

    if @link.update_attributes(params[:link])
      redirect_to link_url(@link)
    else
      flash.now[:errors] = @link.errors.full_messages
      render :edit
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to subs_url
  end

end
