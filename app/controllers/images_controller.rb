# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @post = Post.find(params[:post_id])
    @image = @post.images.find(params[:id])
    @image.purge_later
    redirect_back(fallback_location: root_path)
  end

  def mainimage
    @post = Post.find(params[:post_id])
    @post.mainimage.purge_later
    redirect_back(fallback_location: root_path)
  end
end
