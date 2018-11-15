class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      # handle succesfull save
      flash[:success] = "Welcome to the sample app!" # inserts message into the flash hash and can be displayed on @user page
      redirect_to @user
    else
        render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end