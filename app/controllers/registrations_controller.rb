class RegistrationsController < Devise::RegistrationsController	

	private

	def sign_up_params
		params.require(:user).permit(:first_name, :last_name, :email, :birth_date, :password, :password_confirmation, :credit_card_number)
	end

	def account_update_params
		params.require(:user).permit(:first_name, :last_name, :email, :birth_date, :password, :password_confirmation, :current_password, :credit_card_number)
	end

	def after_inactive_sign_up_path_for(resource)
		new_user_session_path :action => :new, notice: "Por favor confirma tu cuenta para poder logearte!"
	end
	
end