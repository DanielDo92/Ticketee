class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.order(:email)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save!
      flash[:notice] = "User has been created."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been created."
      render "new"
    end
  end

  def show
  end

  def edit
    # code here
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
    end
    if @user.update_attributes(user_params)
      flash[:notice] = "User has been updated."
      redirect_to admin_users_path
    else
      flash[:alert] = "User has not been created."
      render "edit"
    end

  end

  def destroy
    # code here
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
