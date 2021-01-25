class ProfileController < ApplicationController
  before_action :set_user

  def index
    @posts = current_user.posts.order('created_at DESC')
  end

  def show
    @user = User.includes([avatar_attachment: :blob]).find(params[:id])
    @posts = @user.posts.includes([:club]).order('created_at DESC')
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
