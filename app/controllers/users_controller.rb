class UsersController < ApplicationController

  def index
    @users = User.order(:last_name, :first_name).search params[:query], page: params[:page], per_page: 20, highlight: true
  end

end
