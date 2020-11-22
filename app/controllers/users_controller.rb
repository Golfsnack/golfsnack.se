class UsersController < ApplicationController

  def index
    @users = User.order(:last_name, :first_name).page params[:page]
  end

end
