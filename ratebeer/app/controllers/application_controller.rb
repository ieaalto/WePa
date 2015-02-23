class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    return nil if session["user_id"].nil?
    User.find(session[:user_id])
  end

  def authenticate_admin
    authenticate
    if current_user.admin == false || current_user.admin == nil
      redirect_to :back, notice: "You need administrator rights to perform this action"
      return
    end
  end

  def authenticate
    if current_user.nil?
      redirect_to new_session_path
      return
    end
  end
end
