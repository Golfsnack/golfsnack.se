class GuidesController < ApplicationController
  def index
    @latest_guides = Guide.all
  end

  def show
    @guide = Guide.friendly.find(params[:id])
  end
end
