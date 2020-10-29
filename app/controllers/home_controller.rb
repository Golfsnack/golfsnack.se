class HomeController < ApplicationController
  def index
    @latest_articles = Article.limit(3).order("created_at desc")
    @posts = Post.includes(:user).limit(10).order("created_at desc").includes([:rich_text_body])

    friends = current_user.all_following
    @activities = PublicActivity::Activity.includes([:owner, :trackable]).order("created_at desc").where(owner_id: friends).limit(10)
  end
end
