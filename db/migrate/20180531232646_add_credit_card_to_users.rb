class AddCreditCardToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :credit_card_number, :integer
  end
end
