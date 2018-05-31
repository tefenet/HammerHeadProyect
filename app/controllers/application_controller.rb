class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def index
    render "layouts/index"
  end
end
