class AddViajesIdToViajeRecurrente < ActiveRecord::Migration[5.2]
  def change
  	add_reference :viaje_recurrentes, :viajes, foreign_key: true
  end
end
