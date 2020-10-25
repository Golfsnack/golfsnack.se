class HomeController < ApplicationController
  def index
    @latest_guides = Guide.latest
    @posts = Post.all
  end
end
