class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    render :show
  end

  def show
    @user = User.find(params[:id])
  end



 private

  def user_params
    params.require(:user).permit(:username, :email, :password, :avatar)
  end
end
