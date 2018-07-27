class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.references :usuario_puntuador
      t.references :usuario_puntuado
      t.boolean :positivo
      t.boolean :negativo
      t.boolean :neutro
      t.integer :estado
      t.string :comentario

      t.timestamps
    end
  end
end
