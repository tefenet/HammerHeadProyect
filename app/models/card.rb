class Card < ApplicationRecord

	belongs_to :user

 	validates :numero, presence: { message: ": Por favor ingrese el numero de la tarjeta" },
 		uniqueness: { message: ": la tarjeta ya se encuentra registrada"},
 		length: { is: 16, message: ": el numero de la tarjeta debe tener 16 numeros" }
 	validates :numeroSeguridad, presence: { message: ": Por favor ingrese el numero de seguridad" },
 		length: { is: 3, message: ": el numero de seguridad de la tarjeta debe tener 3 numeros" }
 	validates :vencimiento, presence: { message: ": Por favor ingrese la fecha de vencimiento de la tarjeta" }
 	validate :validate_vencimiento 

 	before_destroy :check_if_can_be_destroyed
 	 

 	def check_if_can_be_destroyed 
		#if usuario.solicitud.where(card_id: to_param).where(finalizado: false).count >= 1
		#	throw(:abort)
		#end
	end 

	def validate_vencimiento
		if vencimiento.present? && vencimiento < Date.today
			errors.add(:vencimiento, 'la tarjeta esta vencida') 
		end
	end 
end