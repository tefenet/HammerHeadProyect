class AddReputacionesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :reputacion_chofer, :integer, :null => false, :default => 0
    add_column :users, :reputacion_pasajero, :integer, :null => false, :default => 0
  end
end
