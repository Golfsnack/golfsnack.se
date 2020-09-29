class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :determine_layout


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:golf_id, :first_name, :last_name, :invite_code])
    devise_parameter_sanitizer.permit(:account_update, keys: [:golf_id, :first_name, :last_name, :avatar, :remove_avatar])
  end


  private

  def determine_layout
    current_user ? "application" : "private"
  end
end
