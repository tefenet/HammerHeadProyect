class DeleteSolicitudesYComentarios < ActiveRecord::Migration[5.2]
  def change
  	drop_table :comentarios
  	drop_table :solicitudes
  end
end
