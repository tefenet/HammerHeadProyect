class Semana < ApplicationRecord
  belongs_to :viaje_recurrente
  has_many :viajes, class_name: 'Viaje'
end
