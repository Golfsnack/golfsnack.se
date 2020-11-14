class RegistrationsController < Devise::RegistrationsController
  protected

   def sign_up(resource_name, resource)
    invitation = ::Invitation.where(email: resource.email, code: resource.invite_code).first
    invitation.user = resource
    invitation.claimed_at = Time.now
    invitation.save

    sign_in(resource_name, resource)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_sign_up_path_for(resource)
    registration_steps_path
  end

  def after_update_path_for(resource)
    edit_user_registration_path
  end
end
