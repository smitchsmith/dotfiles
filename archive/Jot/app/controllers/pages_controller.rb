class PagesController < ApplicationController

  before_filter :ensure_access

  def create
    @page = Page.new(params[:page])
    @page.url_fragment = params[:url_fragment]
    @page.owner = current_user

    if @page.save
      # UserMailer.page(page).deliver!
      render json: build_json
    else
      render json: @page.errors, status: 422
    end
  end

  def edit
    # @page defined elsewhere
    @rand_url = generate_rand_url
    @page.syntax = Syntax.find_by_highlighting("plaintext") unless @page.persisted?
    if request.xhr?
      render json: build_json
    else
      redirect_to params[:url_fragment] ? "/jots##{params[:url_fragment]}" : @rand_url
    end
  end

  def update
    @page = Page.find_by_url_fragment(params[:url_fragment])

    if @page.update_attributes(params[:page])
      # UserMailer.page(page).deliver!
      render json: build_json
    else
      render json: @page.errors
    end
  end

  def random
    session[:had_tour] = false
    redirect_to "/#{generate_rand_url}"
  end

  # private

  # move to application controller

  def ensure_access
    @page = Page.find_or_initialize_by_url_fragment(params[:url_fragment])

    unless visible?
      session[:prev_url_fragment] = params[:url_fragment]
      redirect_to ( @page.password_digest ? page_session_url : new_session_url )
    end
  end

  def visible?
    return true if (current_user && current_user == @page.owner)

    if @page.is_public?
      @page.password_digest.nil? ||
      (session[:page_sessions] && session[:page_sessions].include?(@page.id)) ||
      (current_user && user_has_saved_password?)
    else
      (current_user && @page.shared_users.include?(current_user))
    end
  end

  def generate_rand_url
    all_fragments = Page.pluck(:url_fragment)

    loop do
      rand_url = TokenPhrase.generate(numbers: false)
      return rand_url unless all_fragments.include?(rand_url)
    end
  end

  def user_has_saved_password?
    pwd = SavedPassword.find_by_user_id_and_page_id(current_user.id, @page.id)
    pwd && (pwd.digest == @page.password_digest)
  end

  def build_json
      Jbuilder.encode do |json|
        json.(@page, :title, :url_fragment, :is_public, :password_digest, :owner_id, :created_at, :updated_at, :syntax_id, :id)
        json.versions @page.versions
        json.comments @page.comments do |comment|
          json.(comment, :owner_id, :page_id, :body, :created_at, :updated_at, :id)
          json.username comment.owner.username
          json.owner_id comment.owner.id
        end
        json.binaries @page.binaries do |binary|
          json.page_id binary.page_id
          json.title binary.title
          json.url binary.file.url
          json.created_at binary.created_at
          json.updated_at binary.updated_at
          json.id binary.id
        end
      end
  end

end