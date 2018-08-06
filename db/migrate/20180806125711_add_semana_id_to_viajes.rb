class AddSemanaIdToViajes < ActiveRecord::Migration[5.2]
  def change
    add_column :viajes, :semana_id, :integer
  end
end
