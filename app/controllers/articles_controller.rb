# frozen_string_literal: true

class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'application'

  def index
    @articles = Article.includes([:rich_text_body,
                                  { image_attachment: :blob }]).order(created_at: :desc).page params[:page]
    if params[:category]
      @category = Category.where(name: params[:category].capitalize).first
      @articles = @articles.where(category_id: @category.id) if @category
    else
      @latest_articles = (@articles + @articles + @articles).first(8)
    end
  end

  def show
    @article = Article.includes([:rich_text_body, { image_attachment: :blob }]).friendly.find(params[:id])
  end
end
