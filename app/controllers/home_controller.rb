class HomeController < ApplicationController
  def index
    @latest_guides = Guide.latest
  end
end
