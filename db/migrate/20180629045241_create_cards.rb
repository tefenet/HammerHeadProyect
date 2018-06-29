class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|

    	t.integer :numero , unique: true
    	t.integer :numeroSeguridad 
    	t.date :vencimiento

      t.timestamps
    end
  end
end
