class GuidesController < ApplicationController
  def index
    @guides = Guide.all
  end

  def show
    id = params[:slug].split('--').last
    @guide = Guide.by_id(id)
  end
end
