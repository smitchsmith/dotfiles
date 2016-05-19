class PageSessionsController < ApplicationController

  def new
    @page = Page.find_by_url_fragment(params[:url_fragment])
  end

  def create
    @page = Page.find_by_url_fragment(params[:url_fragment])

    unless @page.is_password?(params[:page][:password])
      redirect_to page_session_url(@page.url_fragment)
      return
    end

    if current_user
      @saved_password = SavedPassword.find_or_initialize_by_user_id_and_page_id(current_user.id, @page.id)
      @saved_password.digest = @page.password_digest
      @saved_password.save!
    else
      !session[:page_sessions] && session[:page_sessions] = []
      session[:page_sessions] << @page.id
    end

    redirect_to page_url(@page.url_fragment)
  end

end
