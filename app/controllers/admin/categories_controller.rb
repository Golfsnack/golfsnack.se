# frozen_string_literal: true

module Admin
  class CategoriesController < BaseController
    def new
      @category = Category.new
    end

    def edit
      @category = Category.find(params[:id])
    end

    def index
      @categories = Category.all
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        flash[:success] = 'Kategori skapad'
        redirect_to admin_categories_path
      else
        flash[:error] = 'Något gick fel'
        redirect_to admin_categories_path
      end
    end

    def update
      @category = Category.find(params[:id])
      if @category.update(category_params)
        flash[:success] = 'Kategori uppdaterad'
        redirect_to admin_categories_path
      else
        flash[:error] = 'Något gick fel'
        redirect_to admin_categories_path
      end
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
