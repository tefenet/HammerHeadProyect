class AddUserIdToViajeRecurrentes < ActiveRecord::Migration[5.2]
	# me confundi en realidad agrega la id de viajes
  def change
    add_column :viaje_recurrentes, :viaje_id, :integer
  end
end
