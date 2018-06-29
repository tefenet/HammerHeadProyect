class AddAsientosLibresToViajes < ActiveRecord::Migration[5.2]
  def change
    add_column :viajes, :asientos_libres, :integer
  end
end
