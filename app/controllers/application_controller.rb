class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username, :profile_picture,:phone])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :username,:profile_picture, :phone])
  end

  def is_admin?
    redirect_to root_path unless current_user.is_admin?
  end
end
