class AddUserIdToViajes < ActiveRecord::Migration[5.2]
  def change
    add_column :viajes, :user_id, :integer
  end
end
