class CreateSemanas < ActiveRecord::Migration[5.2]
  def change
    create_table :semanas do |t|
      t.references :viaje_recurrentes, foreign_key: true

      t.timestamps
    end
  end
end
