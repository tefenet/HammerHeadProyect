class UsersController < ApplicationController
  def show
    @user =User.find(params[:id])
    @user_viajes =@user.viajes
  end
end
