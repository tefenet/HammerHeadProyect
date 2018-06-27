class ChangeDuracionToBeIntegerInViajes < ActiveRecord::Migration[5.2]
  def change
  	change_column :viajes, :duracion, :integer
  end
end
