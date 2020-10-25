module Admin
  class GuidesController < BaseController

    def new
      @guide = Guide.new
    end

    def edit
      @guide = Guide.friendly.find(params[:id])
    end

    def index
      @guides = Guide.all
    end

    def create
      @guide = Guide.new(guide_params)
      if @guide.save
        flash[:success] = "Guide skapad"
        redirect_to admin_guides_path
      else
        flash.now[:error] = "Något gick fel"
        render :new
      end
    end

    def update
      @guide = Guide.friendly.find(params[:id])
      if @guide.update(guide_params)
        flash[:success] = "Guide uppdaterad"
        redirect_to admin_guides_path
      else
        flash.now[:error] = "Något gick fel"
        render :edit
      end
    end

    private

    def guide_params
      params.require(:guide).permit(:title, :image, :body)
    end
  end
end
