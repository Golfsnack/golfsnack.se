class PostsController < ApplicationController

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.all
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
      flash[:success] = "Sparade inlägget"
      redirect_to @post
    else
      @clubs = Club.order(:name).all
      flash.now[:error] = "Något gick fel, kunde inte spara"
      render 'new'
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      flash[:success] = "Tog bort inlägget"
    end
    redirect_to profile_path
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      flash[:success] = "Sparade inlägget"
      redirect_to @post
    else
      @clubs = Club.order(:name).all
      flash.now[:error] = "Något gick fel, kunde inte spara"
      render 'edit'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :preamble, :club_id)
  end
end
