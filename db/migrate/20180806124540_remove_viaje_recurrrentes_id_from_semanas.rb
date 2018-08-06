class RemoveViajeRecurrrentesIdFromSemanas < ActiveRecord::Migration[5.2]
  def change
    remove_column :semanas, :viaje_recurrentes_id, :integer
    add_column  :semanas, :viaje_recurrente_id, :integer
  end
end
