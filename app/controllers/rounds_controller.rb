# frozen_string_literal: true

class RoundsController < ApplicationController

  def create
    @club = Club.find(params[:club_id])
    Round.create(club: @club, user: current_user)
    redirect_to club_path(@club)
  end
end
