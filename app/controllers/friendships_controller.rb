class FriendshipsController < ApplicationController

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      user = User.find(params[:friend_id])
      flash[:notice] = "Du följer nu #{user.name}"
      redirect_to user_path(user)
    else
      flash[:notice] = "Något gick fel med att följa användaren"
      redirect_to user_path(user)
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    user = @friendship.friend
    @friendship.destroy
    flash[:notice] = "Du slutade följa #{user.name}."
    redirect_to user_path(user)
  end
end
