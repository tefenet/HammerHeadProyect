class UsersController < ApplicationController
  def show
    @user =User.find(params[:id])
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
    @viajesComoPasajero = nil
    if (@user.viajesComoPasajero != nil)
      @viajesComoPasajero = @user.viajesComoPasajero
    end
  end


private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :birth_date, :credit_card_number, :avatar)
  end
end
