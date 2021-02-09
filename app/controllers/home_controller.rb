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
    @leaderboard_users = User.includes([:sash]).find Merit::Score.top_scored.map{ |s| s["user_id"] }
    @polls = Poll.active.order(:created_at).limit(3).all
    @popular_tags = ActsAsTaggableOn::Tag.most_used(10)
  end
end
