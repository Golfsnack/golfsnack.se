class ProfileController < ApplicationController
  before_action :set_user

  def index
    @posts = current_user.posts
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts

    if @user != current_user
      @friendship = current_user.friendships.where(friend_id: @user.id).first
    end

    render :index
  end

  private

  def set_user
    @user = current_user
  end
end
