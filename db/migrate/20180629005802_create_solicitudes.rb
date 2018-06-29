class CreateSolicitudes < ActiveRecord::Migration[5.2]
  def change
    create_table :solicitudes do |t|
    	t.integer :id_user
    	t.integer :id_viaje
    end
  end
end
