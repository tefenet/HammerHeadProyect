class ViajeRecurrente < ApplicationRecord
	has_many :viaje, class_name: 'Viaje',  foreign_key: "viaje_id"
	has_one :car
	has_many :semanas, :class_name => "Semana", :dependent=> :destroy
	validate :only_mondays


	#link de donde saque este metodo
	# https://stackoverflow.com/questions/7930370/ruby-code-to-get-the-date-of-next-monday-or-any-day-of-the-week

	def date_of_next(day, semana)
  		date  = Date.parse(day)
  		delta = semana * 7
  		return date + delta.days
	end

	def get_next_day(date, day_of_week, semana)
		if (semana == 0)
			real_date = (date)
		else
			real_date = (date + (7*semana))
		end
		return real_date + ((day_of_week - date.wday) % 7)
	end

	def only_mondays
		if !self.fecha.monday?
			errors.add(:inicio, 'Solo puede comenzar un lunes')
    	end
	end

	def viajesSimples
		return self.semanas.map{|s| s.viajes}.flatten
	end

	def lastTravel
		viajesSimples.last
	end

	def removePasajero(user)
		#lo quita de todos a partir del proximo
		#suma un lugar
	end

	def add_Pasajero(aPassenger)
		#lo agrega a todos a partir del proximo
		#resta un lugar
	end

	def asientos_libres
		next_travel.asientos_libres
	end

	def next_travel
		return (self.viajesSimples.select{ |un_viaje| un_viaje.not_started }.first)
	end

	def start_time
		return self.next_travel.startT
	end

end
