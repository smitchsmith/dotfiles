class ContactSharesController < ApplicationController

  def create
    contact_share = ContactShare.new(params[:contact_share])
    if contact_share.save
      render :json => contact_share
    else
      render :json => contact_share.errors.full_messages, :status => :unprocessable_entity
    end
  end

  def destroy
    id = params["id"]
    contact_share = ContactShare.find(id)
    contact_share.delete
    render :json => contact_share
  end

end