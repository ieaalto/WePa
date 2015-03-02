class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :suspend]
  before_action :authenticate_admin, only: [:suspend]

  # GET /users
  # GET /users.json
  def index
    @users = User.includes(:beers, :ratings).all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user == current_user
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to :root, notice:"Not logged in!"
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user == current_user
      session[:user_id] = nil
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end
    else
      redirect_to :root, notice:"Not logged in!"
    end
  end

  def suspend
    if @user.suspended
      @user.update_attribute(:suspended, false)
      redirect_to users_path, notice: "User no longer suspended!"
    else
      @user.update_attribute(:suspended, true)
      redirect_to users_path, notice: "User suspended!"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end
end
