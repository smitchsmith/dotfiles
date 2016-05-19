class SharesController < ApplicationController

  before_filter :ensure_owner_present, only: :index
  before_filter :ensure_can_share, only: :index

  def index
    # @page instantiated elsewhere if before_filters on
    @owner = @page.owner
    @shares = @page.shares

    users = User.all
    # @shared_users instantiated elsewhere
    @possible_shares = users.reject { |user| @shared_users.include?(user) || user == current_user || user == @owner }
    if request.xhr? && owner_present? && can_share?
      render :index, layout: false
    else
      render "You can't share this page!"
    end
  end

  # for security, would need before_filters for these too

  def create
    page = Page.find_by_url_fragment(params[:url_fragment])
    sharee = User.find(params[:share][:sharee_id])
    share = Share.create!({ page_id: page.id, sharer_id: current_user.id, sharee_id: sharee.id })
    # UserMailer.share(page).deliver!

    if request.xhr?
      render json: share
    else
      redirect_to shares_url(page.url_fragment)
    end
  end

  def destroy
    share = Share.find(params[:id])
    share.destroy
    if request.xhr?
      render json: share
    else
      redirect_to shares_url(share.page.url_fragment)
    end
  end

  # private

  def ensure_owner_present
    @page = Page.find_by_url_fragment(params[:url_fragment])
    redirect_to page_url(@page.url_fragment) unless @page.owner
  end

  def ensure_can_share
    # @page instantiated elsewhere
    @shared_users = @page.shared_users
    unless @shared_users.include?(current_user) || @page.owner == current_user
      redirect_to page_url(@page.url_fragment)
    end
  end

  def owner_present?
    @page = Page.find_by_url_fragment(params[:url_fragment])
    !!@page.owner
  end

  def can_share?
    # @page instantiated elsewhere
    @shared_users = @page.shared_users
    @shared_users.include?(current_user) || @page.owner == current_user
  end

end
