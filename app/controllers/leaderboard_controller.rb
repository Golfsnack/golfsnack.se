class LeaderboardController < ApplicationController
  def index
    @leaderboard = Merit::Score.top_scored
    @users = User.find @leaderboard.map{ |s| s["user_id"] }
  end
end
