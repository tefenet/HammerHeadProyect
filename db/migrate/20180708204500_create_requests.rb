class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :state
      t.integer :passengerScore
      t.integer :driverScore
      t.references :user
      t.references :viaje

      t.timestamps
    end
  end
end
