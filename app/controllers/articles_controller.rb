class ArticlesController < ApplicationController
  def index
    @latest_articles = Article.all
  end

  def show
    @article = Article.friendly.find(params[:id])
  end
end
