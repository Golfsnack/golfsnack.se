class ApplicationController < ActionController::Base
  include SessionCurrentUser

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :determine_layout

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:invite_code])
    devise_parameter_sanitizer.permit(:account_update, keys: [:golf_id, :first_name, :last_name, :avatar, :remove_avatar, :cover, :remove_cover, :club_id, :info])
  end

  def after_sign_in_path_for(resource)
    if resource.completed_profile?
      root_path
    else
      edit_user_registration_path
    end
  end

  private

    def determine_layout
      current_user ? "application" : "private"
    end
end
