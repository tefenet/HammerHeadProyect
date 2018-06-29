class ComentariosController < ApplicationController

	before_action :find_viaje

	def create
		@comentario = @viaje.comentarios.create(params[:comentario].permit(:texto))
		@comentario.save

		if @comentario.save
			redirect_to viaje_path(@viaje)
		else
			render 'new'
		end
	end



	private

	def find_viaje
		@viaje = Viaje.find(params[:viaje_id])
	end

end
