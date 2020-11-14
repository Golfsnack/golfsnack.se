class ClubsController < ApplicationController

  def index
    @clubs = Club.order(:name).page params[:page]
  end

  def show
    @club = Club.find(params[:id])
  end

end
