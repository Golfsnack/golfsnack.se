class ArticlesController < ApplicationController
  def index
    @articles = Article.includes([:rich_text_body, image_attachment: :blob]).order(created_at: :desc).page params[:page]
    @latest_articles = (@articles + @articles + @articles).first(8)
  end

  def show
    @article = Article.friendly.find(params[:id])
  end
end
