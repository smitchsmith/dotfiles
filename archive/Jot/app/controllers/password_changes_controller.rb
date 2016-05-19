class PasswordChangesController < ApplicationController

  def new
    find_changer
    if request.xhr?
      render :new, layout: false
    end
  end

  def create
    find_changer
    password1 = params[:password1]

    if password1 == params[:password2] && @changer.is_password?(params[:old_password])
      @changer.password = password1
      @changer.save!
      if request.xhr?
        render json: @changer
      else
        redirect_to ( @klass == User ? user_url(@value) : page_url(@value) )
      end
    else
      if request.xhr?
        render :new, layout: false
      else
        redirect_to @url
      end
    end
  end

  # private

  def find_changer
    id, url_fragment = params[:id], params[:url_fragment]

    if id
      @klass, @value, @changer = [User, id, User.find(id)]
    else
      @klass, @value = [Page, url_fragment]
      @changer = Page.find_by_url_fragment(url_fragment)
    end

    @url = generate_url
  end

  def generate_url
    send("#{@klass.to_s.downcase}_change_password_url".to_sym, @value)
  end

end
