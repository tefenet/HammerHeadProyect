class AddSemanasIdToViajeRecurrentes < ActiveRecord::Migration[5.2]
  def change
  	rename_column :viaje_recurrentes, :semanas, :cant_semanas
  	add_reference :viaje_recurrentes, :semanas, foreign_key: true
  end
end
