class AddViajeIdToComments < ActiveRecord::Migration[5.2]
  def change
  	add_reference :comments, :viaje, foreign_key: true
  end
end
