class CreateUsersViajesJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_join_table :viajes, :users do |t|
    t.index :viaje_id
    t.index :user_id
  end
end
end
