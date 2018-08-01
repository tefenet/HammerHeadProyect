class AddFechaToScores < ActiveRecord::Migration[5.2]
  def change
  	add_column :scores, :fecha, :date
  end
end
