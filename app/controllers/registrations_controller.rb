class RegistrationsController < Devise::RegistrationsController	

	private

	def sign_up_params
		params.require(:user).permit(:first_name, :last_name, :email, :birth_date, :password, :password_confirmation, :credit_card_number)
	end

	def account_update_params
		params.require(:user).permit(:first_name, :last_name, :email, :birth_date, :password, :password_confirmation, :current_password, :credit_card_number)
	end
	
end