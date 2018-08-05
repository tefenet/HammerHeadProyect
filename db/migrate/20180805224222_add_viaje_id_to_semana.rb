class AddViajeIdToSemana < ActiveRecord::Migration[5.2]
  def change
  	add_reference :semanas, :viajes, foreign_key: true
  end
end
