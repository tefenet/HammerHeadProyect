class ApplicationController < ActionController::Base

  #protect_from_forgery with: :exception
  #before_filter :configure_permitted_parameters, if: :devise_controller?

  #protected
  before_action :set_host_from_request, only: [:create]

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user

  def set_current_user
    User.current=(current_user)
  end

  def index
    render "layouts/index"
  end

  def balance
    render "layouts/balance"
  end


  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  private
    def set_host_from_request
      ActionMailer::Base.default_url_options = { host: request.host_with_port }
    end
end
