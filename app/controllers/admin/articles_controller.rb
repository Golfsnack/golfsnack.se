module Admin
  class ArticlesController < BaseController

    def new
      @article = Article.new
    end

    def edit
      @article = Article.friendly.find(params[:id])
    end

    def index
      @articles = Article.all
    end

    def create
      @article = Article.new(article_params)
      if @article.save
        flash[:success] = "Artikel skapad"
        redirect_to admin_articles_path
      else
        flash.now[:error] = "Något gick fel"
        render :new
      end
    end

    def update
      @article = Article.friendly.find(params[:id])
      if @article.update(article_params)
        flash[:success] = "Artikel uppdaterad"
        redirect_to admin_articles_path
      else
        flash.now[:error] = "Något gick fel"
        render :edit
      end
    end

    private

    def article_params
      params.require(:article).permit(:title, :image, :body)
    end
  end
end
