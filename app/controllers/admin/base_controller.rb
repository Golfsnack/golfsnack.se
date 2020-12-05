module Admin
  class BaseController < ApplicationController
    before_action :restrict_user_by_role

    def index
      @invitations = Invitation.includes(:user).all
      @invite = Invitation.new
    end

    def create
      attrs = invitation_params

      @invite = Invitation.new(attrs)

      if User.where(email: attrs[:email]).size > 0
        flash.now[:error] = "Användare med denna E-post finns redan"
      else
        if Invitation.where(email: attrs[:email]).size > 0
          flash.now[:error] = "Inbjudan redan skapad till denna E-post"
        else
          @invite.code = generate_token

          if @invite.save
            flash.now[:success] = "Sparade"
          else
            flash.now[:error] = "Kunde inte spara"
          end
        end
      end

      @invitations = Invitation.all
      render :index
    end

    protected

    def restrict_user_by_role
      unless current_user or !current_user.has_role?(:admin)
        redirect_to root_path
      end
    end

    private

    def invitation_params
      params.require(:invitation).permit(:email)
    end

    def generate_token
      loop do
        token = SecureRandom.hex(5)
        break token unless Invitation.where(code: token).exists?
      end
    end
  end
end
