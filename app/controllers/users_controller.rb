class UsersController < ApplicationController
  before_action :logged_in_user,only:[:edit,:update]
  before_action :correct_user , only:[:edit,:update]
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new()
  end
  def create
    @user = User.new(user_params)
    if @user.save
      # handle succesfull save
      log_in @user
      flash[:success] = "Welcome to the sample app!" # inserts message into the flash hash and can be displayed on @user page
      redirect_to @user
    else
        render 'new'
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      #Handle a succesfull update
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:additional_details)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please Log In"
      redirect_to login_url
    end
  end
  # confirms the correct users
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
end
