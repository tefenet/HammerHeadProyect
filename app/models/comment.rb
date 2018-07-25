class Comment < ApplicationRecord
	belongs_to :viaje
	belongs_to :user, optional: true 

	validates :pregunta, presence: { message: ": Por favor ingrese su pregunta" }
	validates :respuesta, presence: { message: " : Por favor ingrese una respuesta"}, on: :update


end