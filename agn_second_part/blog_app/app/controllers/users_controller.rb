# controller for managing users
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!
  before_action :set_user, only: [:show, :edit, :update]

  # lists all users
  def index
    @users = User.all
  end

  # shows single user details
  def show
  end

  # renders form for creating new user
  def new
    @user = User.new
  end

  # creates new user
  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # renders form for editing user
  def edit
  end

  # updates user details
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  # finds user by id
  def set_user
    @user = User.find(params[:id])
  end

  # safe parameters for user
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  # ensures only admin can access
  def ensure_admin!
    unless current_user.admin?
      redirect_to root_path, alert: "You must be an admin to access this page."
    end
  end
end
