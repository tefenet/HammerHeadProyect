class AddCarIdToViajes < ActiveRecord::Migration[5.2]
  def change
       add_reference :viajes, :car, foreign_key: true
  end
end
