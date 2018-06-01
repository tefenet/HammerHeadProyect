class AddCarIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :car_id, :integer
  end
end
