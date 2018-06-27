class AddPasajNchof < ActiveRecord::Migration[5.2]
  def change
    add_reference :viajes, :pasajero
    add_reference :viajes, :chofer
    add_column :viajes, :car_plate, :string
    add_column :cars, :viaje_id, :integer
  end
end
