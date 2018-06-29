class RemoveCreditCardNumberFromUser < ActiveRecord::Migration[5.2]
  def change
  	remove_column :users, :credit_card_number
  end
end
