class ViajeRecurrente < ApplicationRecord
	has_many :viaje, class_name: 'Viaje',  foreign_key: "viaje_id"
	has_one :car
	has_many :semanas, :class_name => "Semana"

	#link de donde saque este metodo 
	# https://stackoverflow.com/questions/7930370/ruby-code-to-get-the-date-of-next-monday-or-any-day-of-the-week

	def date_of_next(day)
  		date  = Date.parse(day)
  		delta = date > Date.today ? 0 : 7
  		return date + delta
	end
end
