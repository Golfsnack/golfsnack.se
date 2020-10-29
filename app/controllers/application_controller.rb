class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

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

# Front page activities
# @activities = PublicActivity::Activity.joins("INNER JOIN users ON activities.owner_id = users.id").order(created_at: :desc).paginate(page: params[:page], per_page: 10)
