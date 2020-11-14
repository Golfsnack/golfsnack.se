class RegistrationStepsController < ApplicationController
  skip_before_action :completed_profile
  include Wicked::Wizard
  steps :personal

  def show
    @clubs = Club.order(:name).all
    @user = current_user
    render_wizard
  end

  def update
    @clubs = Club.order(:name).all
    @user = current_user
    @user.attributes = user_params
    render_wizard @user
  end

  def finish_wizard_path
    root_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :golf_id, :club_id)
  end
end

