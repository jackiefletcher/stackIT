class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def logged_in?
    !!session[:user_id]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if logged_in?
  end

  def require_user
    unless logged_in?
      flash[:alert] = "Access denied!"
      redirect_to root_path
    end
  end

end
