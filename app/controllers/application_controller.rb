class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def log_in_user!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def logged_in?
    !current_user.nil?
  end

  def current_band
    @current_band ||= Band.find_by_id(params[:id])
  end

  def current_album
    @current_album ||= Album.find_by_id(params[:id])
  end

  def current_track
    @current_track ||= Track.find_by_id(params[:id])
  end
end
