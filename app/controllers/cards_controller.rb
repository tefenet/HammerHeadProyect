class CardsController < ApplicationController

	def index
		@cards = Card.where(user_id: current_user.id)
	end

	def show
		@card = Card.find(params[:id])
	end

	def new
		@card = Card.new
	end

	def edit
      @card =Card.find(params[:id])
  end

	def update
    @usuario = current_user
		@card =Card.find(params[:id])
		if @card.update(card_params)
			redirect_to @card
		else
		 	render :edit
		end
	end

	def create
		@card = current_user.cards.new(card_params)
		if @card.save
			@card.vencimiento = @card.vencimiento.change(:day => 1)
			@card.save
			redirect_to @card
		else
		 	render :new
		end
	end

	def delete
		@card = Card.delete
	end


	def destroy
		@user = current_user
		if @user.viajesPendientes then
			redirect_to cards_path and return flash[:notice] = 'No puede eliminar la tarjeta porque tiene viajes pendientes'
		else
			@card = Card.find(params[:id]).destroy
			redirect_to cards_path and return flash[:notice] = 'Tarjeta eliminada'
		end
	end

	private

	def validate_usuario
		redirect_to new_usuario_session_path, notice: "Debes iniciar sesion"
	end

	def card_params
		params.require(:card).permit(:numero,:numeroSeguridad,:vencimiento)
	end
end
