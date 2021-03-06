class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @u ||= User.find_by_session_token(session[:session_token])
  end

  def signed_in?
    !!current_user
  end

  def login!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  helper_method :signed_in?, :current_user
end
