# frozen_string_literal: true

module Admin
  class InvitesController < BaseController
    def index
      @invitations = Invitation.includes(:user).order(created_at: :desc).all
      @invite = Invitation.new
    end

    def create
      attrs = invitation_params

      @invite = Invitation.new(attrs)

      if User.where(email: attrs[:email]).size.positive?
        flash.now[:error] = 'Användare med denna E-post finns redan'
      elsif Invitation.where(email: attrs[:email]).size.positive?
        flash.now[:error] = 'Inbjudan redan skapad till denna E-post'
      else
        @invite.code = generate_token

        if @invite.save
          flash.now[:success] = 'Sparade'
        else
          flash.now[:error] = 'Kunde inte spara'
        end
      end

      @invitations = Invitation.all
      redirect_to admin_invites_path
    end

    private

    def invitation_params
      params.require(:invitation).permit(:email)
    end

    def generate_token
      loop do
        token = SecureRandom.hex(5)
        break token unless Invitation.exists?(code: token)
      end
    end
  end
end
