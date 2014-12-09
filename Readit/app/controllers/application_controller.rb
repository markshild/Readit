class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  def login(user)
    @current_user = user
    session[:session_token] = @current_user.reset_token!
  end

  def logout
    @current_user.reset_token! if signed_in?
    session[:session_token] = nil
    redirect to new_session_url
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def signed_in?
    !!current_user
  end
end
