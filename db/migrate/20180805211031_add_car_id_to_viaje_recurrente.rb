class AddCarIdToViajeRecurrente < ActiveRecord::Migration[5.2]
  def change
  	add_reference :viaje_recurrentes, :car, foreign_key: true
  end
end
