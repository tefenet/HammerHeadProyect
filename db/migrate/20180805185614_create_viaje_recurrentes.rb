class CreateViajeRecurrentes < ActiveRecord::Migration[5.2]
  def change
    create_table :viaje_recurrentes do |t|
      t.integer :semanas
      t.string :origen
      t.string :destino
      t.date :fecha
      t.time :hora
      t.float :precio
      t.time :duracion
      t.text :descripcion
      t.boolean :lunes, :null => false ,:default => false
      t.boolean :martes, :null => false ,:default => false
      t.boolean :miercoles, :null => false ,:default => false
      t.boolean :jueves, :null => false ,:default => false
      t.boolean :viernes, :null => false ,:default => false
      t.boolean :sabado, :null => false ,:default => false
      t.boolean :domingo, :null => false ,:default => false
      t.timestamps
    end
  end
end
