class ViajeRecurrente < ApplicationRecord
	has_many :viaje, class_name: 'Viaje',  foreign_key: "viaje_id"
end
