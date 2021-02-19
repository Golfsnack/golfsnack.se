class ClubsController < ApplicationController

  def index
    @clubs = Club.order('users_count DESC').order('posts_count DESC').order(:name).page params[:page]
  end

  def show
    @club = Club.find(params[:id])
    @posts = @club.posts.includes(:user).limit(10).order("created_at desc").includes([:rich_text_body])
  end

  def search
    @clubs = Club.search params[:query], operator: "or", fields: [:name], match: :word_middle, page: 0, per_page: 5
    render layout: false
  end
end
