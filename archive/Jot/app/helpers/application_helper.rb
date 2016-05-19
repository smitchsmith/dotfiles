module ApplicationHelper

  def authenticity_token
      "<input type=\"hidden\" name=\"authenticity_token\" value=\"<%= form_authenticity_token %>\" >".html_safe
  end

  def sign_in!(user)
    session_token = user.session_tokens.create!
    session[:token] = session_token.token
  end

  def current_user
    # @current_user ||= User.find_by_session_token(session[:token])
    session_token = SessionToken.find_by_token(session[:token])
    @current_user ||= session_token.user if session_token
  end

  def sign_out!(user)
    SessionToken.find_by_token(session[:token]).destroy
    session[:token] = nil
  end

  # def ensure_signed_in
  #   redirect_to :root unless current_user
  # end

end
