class Semana < ApplicationRecord
  belongs_to :viaje_recurrentes
  has_many :viajes, class_name: 'Viaje',  foreign_key: "viaje_id"
end
