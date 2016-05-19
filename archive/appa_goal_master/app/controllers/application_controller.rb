class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :auth_token, :current_user

  def auth_token
    "<input type=\"hidden\"
      name=\"authenticity_token\"
      value=\"#{form_authenticity_token}\">".html_safe
  end

  def current_user
    @current_user ||= User.find_by_token(session[:token])
  end
end
