class HomeController < ApplicationController
  def index
    @home = "home"
    @article = Article.order("created_at desc").first
    if params[:tag]
      @tag = params[:tag]
      @posts = Post.tagged_with(params[:tag]).includes(user: [avatar_attachment: :blob]).includes([:club]).order("created_at desc").page(params[:page]).per(50)
    else
      @posts = Post.includes(user: [avatar_attachment: :blob]).includes([:club]).order("created_at desc").page(params[:page]).per(50)
    end
    @user = current_user
    user_ids = Merit::Score.top_scored(since: Date.yesterday).map{ |s| s["user_id"] }
    @leaderboard_users = User.includes([:sash]).find user_ids
    @polls = Poll.active.order(:created_at).limit(3).all
    @popular_tags = ActsAsTaggableOn::Tag.most_used(10)
  end
end
