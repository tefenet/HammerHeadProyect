class ViajeRecurrente < ApplicationRecord
	has_many :viaje, class_name: 'Viaje',  foreign_key: "viaje_id"
	has_one :car
	has_many :semanas, :class_name => "Semana", :dependent=> :destroy

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

end
