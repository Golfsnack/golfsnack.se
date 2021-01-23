class HomeController < ApplicationController
  def index
    @home = "home"
    @article = Article.order("created_at desc").first
    @posts = Post.includes(:user).limit(10).order("created_at desc").includes([:rich_text_body])
    @user = current_user
    @leaderboard_users = User.find Merit::Score.top_scored.map{ |s| s["user_id"] }
    @polls = Poll.active.order(:created_at).limit(3).all
  end
end
