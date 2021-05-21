# frozen_string_literal: true

class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show]
  layout 'application'

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.all
    @allmediasize = 0
    @allmediasize = @allmediasize + 1 if @post.youtube_url.present?
    @allmediasize = @allmediasize + 1 if @post.mainimage.attached?
    @allmediasize = @allmediasize + @post.images.size
  end

  def new
    @clubs = Club.order(:name).all
    @post = Post.new
  end

  def edit
    @clubs = Club.order(:name).all
    @post = current_user.posts.find(params[:id])
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:success] = 'Sparade golfsnacket'
      redirect_to @post, status: :see_other, notice: 'Sparade golfsnacket'
    else
      @clubs = Club.order(:name).all
      flash.now[:error] = 'Något gick fel, kunde inte spara'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    flash[:success] = 'Tog bort golfsnack' if @post.destroy
    redirect_to profile_path
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      flash[:success] = 'Sparade golfsnack'
      redirect_to @post
    else
      @clubs = Club.order(:name).all
      flash.now[:error] = 'Något gick fel, kunde inte spara'
      render 'edit'
    end
  end

  def delete_image
    image = ActiveStorage::Attachment.find(params[:id])
    image.attachments.first.purge_later
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :club_id, :mainimage, :youtube_url, tag_list: [], images: [])
  end
end
