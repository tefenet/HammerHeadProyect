class CardsController < ApplicationController

	def index
		@cards = Card.all
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
		@card= Card.delete
	end


	def destroy
      @card = Card.find(params[:id]).destroy
      render :index
    end

	private

	def validate_usuario
		redirect_to new_usuario_session_path, notice: "Debes iniciar sesion"
	end

	def card_params
		params.require(:card).permit(:numero,:numeroSeguridad,:vencimiento)
	end
end
