class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

  def login(user)
    @current_user = user
    session[:session_token] = @current_user.reset_token!
  end

  def logout
    current_user.reset_token! if signed_in?
    session[:session_token] = nil
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def signed_in?
    !!current_user
  end

  def current_is_moderator
    unless current_user.id == Sub.find(params[:id]).moderator_id
      redirect_to subs_url
    end
  end

  def post_author_is_user
    unless current_user.id == Post.find(params[:id]).author_id
      redirect_to post_url(Post.find(params[:id]))
    end
  end
end
