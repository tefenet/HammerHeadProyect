class AddIdsToCommentarios < ActiveRecord::Migration[5.2]
  def change
  	add_column :comentarios, :viaje_id, :integer
  	add_column :comentarios, :user_id, :integer
  	add_column :comentarios, :comentario_id, :integer
  end
end
