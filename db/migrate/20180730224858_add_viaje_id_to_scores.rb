class AddViajeIdToScores < ActiveRecord::Migration[5.2]
  def change
  	add_column :scores, :viaje_id, :integer
  end
end
