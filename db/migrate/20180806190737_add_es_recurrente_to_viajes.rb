class AddEsRecurrenteToViajes < ActiveRecord::Migration[5.2]
  def change
  	add_column :viajes, :es_recurrente, :boolean, :null => false ,:default => false
  end
end
