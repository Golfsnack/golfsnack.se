class HomeController < ApplicationController
  def index
    @latest_articles = Article.limit(3).order("created_at desc")
    @posts = Post.includes(:user).limit(10).order("created_at desc").includes([:rich_text_body])
  end
end
