class UsersController < ApplicationController
  def show
    @user =User.find(params[:id])

    @user_viajes = @user.viajesComoChofer

  end

  def edit
      @user =User.find(params[:id])
  end

  def update
    @user =User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def viajes
    @user =User.find(params[:id])
    @viajesComoChofer = @user.viajesComoChofer
    @viajesComoPasajero = SearchHelper.viajesdeUser(current_user)
  end

  def cars
    @user =User.find(params[:id])
    @cars = @user.cars
  end

  def requests
    path=request.path

    if params[path] && !params[path][:reqState].blank?
        @requests = SearchHelper.request_filter(params[path][:reqState])
    else
        @requests = SearchHelper.req_All
    end
  end

private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :birth_date, :credit_card_number, :avatar, :reqState)
  end
end
