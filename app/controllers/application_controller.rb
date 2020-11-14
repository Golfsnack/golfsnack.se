class ApplicationController < ActionController::Base
  before_action :completed_profile
  include PublicActivity::StoreController
  include SessionCurrentUser

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :determine_layout

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:invite_code])
    devise_parameter_sanitizer.permit(:account_update, keys: [:golf_id, :first_name, :last_name, :avatar, :remove_avatar, :club_id])
  end

  def after_sign_in_path_for(resource)
    if resource.completed_profile?
      root_path
    else
      registration_steps_path
    end
  end

  def completed_profile
    if current_user
      if !current_user.completed_profile?
        flash[:error] = "Du måste komplettera din profil"
        redirect_to registration_steps_path
      end
    end
  end

  private

    def determine_layout
      current_user ? "application" : "private"
    end
end

# Front page activities
# @activities = PublicActivity::Activity.joins("INNER JOIN users ON activities.owner_id = users.id").order(created_at: :desc).paginate(page: params[:page], per_page: 10)
