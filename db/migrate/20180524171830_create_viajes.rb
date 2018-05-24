class CreateViajes < ActiveRecord::Migration[5.2]
  def change
    create_table :viajes do |t|
      t.string :origen
      t.string :destino
      t.date :fecha
      t.time :hora
      t.float :precio
      t.time :duracion
      t.text :descripcion

      t.timestamps
    end
  end
end
