class LeaderboardController < ApplicationController
  def index
    @leaderboard = Merit::Score.top_scored
    @users = User.includes([:sash, avatar_attachment: :blob]).find @leaderboard.map{ |s| s["user_id"] }
  end
end
