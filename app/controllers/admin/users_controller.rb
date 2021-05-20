# frozen_string_literal: true

module Admin
  class UsersController < BaseController

    def edit
      @user = User.find(params[:id])
      @roles = %w[admin moderator premium ambassador verified]
    end

    def index
      @users = User.all
    end

    def update
      @user = User.find(params[:id])
      roles_to_remove = @user.roles.where(resource_type: nil).where.not(name: user_params[:input_roles]).all

      roles_to_remove.each do |rtr|
        @user.remove_role rtr.name.to_sym
      end

      user_params[:input_roles].each do |rta|
        @user.add_role rta
      end

      flash[:success] = 'Användare uppdaterad'
      redirect_to admin_users_path
    end

    private

    def user_params
      params.require(:user).permit(input_roles: [])
    end
  end
end
