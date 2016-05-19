class ContactsController < ApplicationController

  def index
    user_id = params["user_id"]
    render :json => Contact.contacts_for_user_id(user_id)
  end

  def create
    contact = Contact.new(params[:contact])
    if contact.save
      render :json => contact
    else
      render :json => contact.errors.full_messages, :status => :unprocessable_entity
    end
  end

  def show
    id = params["id"]
    contact = Contact.find(id)
    if contact
      render :json => contact
    else
      render :text => "Contact not found"
    end
  end

  def update
    id = params["id"]
    contact = Contact.find(id)
    if contact.update_attributes(params["contact"])
      render :json => contact
    else
      render :json => contact.errors.full_messages
    end
  end

  def destroy
    id = params["id"]
    contact = Contact.find(id)
    contact.delete
    render :json => contact
  end

end
