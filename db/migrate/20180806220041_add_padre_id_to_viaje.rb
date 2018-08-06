class AddPadreIdToViaje < ActiveRecord::Migration[5.2]
  def change
  	add_column :viajes, :padreID, :integer
  end
end
