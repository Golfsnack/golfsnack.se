class ProfileController < ApplicationController
  before_action :set_user

  def index
    @posts = current_user.posts.order('created_at DESC')
    render :show
  end

  def show
    @user = User.includes([avatar_attachment: :blob]).find(params[:id])
    @posts = @user.posts.includes([:club]).order('created_at DESC')
  end

  def blog
    @posts = current_user.posts.order('created_at DESC')
  end

  def avatar;end
  def coverimage;end

  def delete_avatar
    @user.avatar.purge_later
    redirect_to profile_path
  end

  def delete_cover
    @user.cover.purge_later
    redirect_to profile_path
  end

  def update_avatar
    decoded_data = Base64.decode64(user_params[:avatar].split(',')[1])
    @user.avatar = {
      io: StringIO.new(decoded_data),
      content_type: 'image/png',
      filename: "avatar-#{@user.id}.png"
    }
    @user.save
    redirect_to profile_path
  end

  def update_cover
    decoded_data = Base64.decode64(user_params[:cover].split(',')[1])
    @user.cover = {
      io: StringIO.new(decoded_data),
      content_type: 'image/png',
      filename: "cover-#{@user.id}.png"
    }
    @user.save
    redirect_to profile_path
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:avatar, :cover)
  end
end
