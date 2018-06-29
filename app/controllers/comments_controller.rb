class CommentsController < ApplicationController

    def preguntasViaje
		@comments = Viaje.find(params[:id]).comments
	end

	def update
		@comment =Comment.find(params[:id])
		if @comment.update(comment_params)
			redirect_to :action => "preguntasViaje", :id => @comment.viaje.id, :flash => { :notice => "Respuesta guardada" }
		else
		 	redirect_to :action => "preguntasViaje", :id => @comment.viaje.id, :flash => { :notice => @comment.errors.full_messages.join(', ') }
		end 		
	end


    def new
    	@viaje = Viaje.find(params[:idViaje])
		@comment = Comment.new
    end
    def create
    	@usuarios = User.all
		@viaje = Viaje.find(params[:comment][:viaje_id])   	
		@comment = @viaje.comments.new(comment_params)
		current_user.comments.new(comment_params)
		if @comment.save
			redirect_to viaje_path(@viaje.id)
		else
			redirect_to viaje_path(@viaje.id), :flash => { :notice => @comment.errors.full_messages.join(', ') }
		end 	
    end
    def comment_params
		params.require(:comment).permit(:pregunta,:respuesta,:respondida)
	end

	def validate_usuario
		redirect_to new_usuario_session_path, notice: "Debes iniciar sesion"
	end	
end