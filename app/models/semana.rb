class Semana < ApplicationRecord
  belongs_to :viaje_recurrente, class_name:'ViajeRecurrente'
  has_many :viajes, class_name: 'Viaje', :dependent=> :destroy
end
