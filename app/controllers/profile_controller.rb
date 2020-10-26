class ProfileController < ApplicationController
  before_action :set_user

  def index
    @posts = current_user.posts
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts

    @activities = PublicActivity::Activity.where(owner: @user).order(created_at: :desc).all

    render :index
  end

  # TODO: Not live here!
  # def mentionable
  #   render json: @user.following_users.as_json(only: [:id, :name]), root: false
  # end

  private

  def set_user
    @user = current_user
  end
end
