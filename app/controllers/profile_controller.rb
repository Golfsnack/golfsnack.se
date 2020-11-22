class ProfileController < ApplicationController
  before_action :set_user

  def index
    @posts = current_user.posts.order('created_at DESC')
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC')
    render :index
  end

  def blog
    @posts = current_user.posts.order('created_at DESC')
  end

  private

  def set_user
    @user = current_user
  end
end
