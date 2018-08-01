class AddTipoToSocres < ActiveRecord::Migration[5.2]
  def change
    add_column :scores, :tipo, :string
  end
end
