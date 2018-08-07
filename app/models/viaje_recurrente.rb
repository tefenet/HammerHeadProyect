class ViajeRecurrente < ApplicationRecord
	has_many :viaje, class_name: 'Viaje',  foreign_key: "viaje_id"
	has_one :car
	has_many :semanas, :class_name => "Semana", :dependent=> :destroy
	validate :only_mondays
	validates :origen, presence: { message: ": Por favor ingrese el origen del viaje"}, on: [:create, :new, :update]
	validates :destino, presence: { message: ": Por favor ingrese el destino del viaje"}, on: [:create, :new, :update]
  validates :fecha, presence: {message: ": Por favor ingrese una fecha para el viaje"}, on: [:create, :new, :update]
  validates :hora, presence: {message: ": Por favor ingrese una hora para el viaje"}, on: [:create, :new, :update]
  validates :precio, presence: { message: ": Por favor ingrese el precio del viaje"}, on: [:create, :new, :update]
  validates :duracion, presence: { message: ": Por favor ingrese una duracion para el viaje"}, on: [:create, :new, :update]

	def anular
			self.semanas.each do |s|
				s.viajes.reject{|v| v.fecha > Date.today}.each do |vi| vi.update_column(:padreID,nil) end
			end
	end
	def check_solicitudes_aprobadas
		prox= self.next_travel
		if !prox.nil?
		if prox.pasajeros.any?
      chofer = User.find(prox.chofer_id)
      if (chofer.reputacion_chofer != 0)
        chofer.reputacion_chofer -= 1
      end
      prox.pasajeros.each { |pas|  MyMailer.viajeBaja(pas, self).deliver_later(wait: 0.001.second)}
      chofer.save
    end
		end
	end

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

	def removePasajero(aPassenger)
		proximos.each do |v| v.removePasajero(aPassenger) end
		#lo quita de todos a partir del proximo
		#suma un lugar
	end
	def proximos
		viajesSimples.select{|v| v.fecha >= next_travel.fecha}
	end

	def add_Pasajero(aPassenger)
		proximos.each do |v| v.add_Pasajero(aPassenger) end
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
