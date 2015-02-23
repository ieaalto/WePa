class SessionsController < ApplicationController
  before_action :auth_suspended, only: [:create]

  def new
  end

  def create
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to @user, notice: "Welcome!"
    else
      redirect_to :back, notice: "Invalid password or username!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end

  def auth_suspended
    @user = User.find_by(username:params[:username])
    if @user && @user.suspended
      redirect_to :back, notice: "Your account is suspended."
      return
    end
  end
end