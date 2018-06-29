class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
    	t.text :pregunta
    	t.string :respuesta, default: ''
    	t.boolean :respondida, default: false
    	t.timestamps
    end
  end
end
