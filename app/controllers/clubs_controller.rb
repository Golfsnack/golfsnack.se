# frozen_string_literal: true

class ClubsController < ApplicationController
  before_action :check_if_moderator, except: %i[index show search]

  USERS_COUNT_TO_SHOW = 6

  def index
    @clubs = Round.limit(5).map(&:club)
  end

  def show
    @club = Club.find(params[:id])
    @users = Merit::Score.top_scored_by_owner(@club.id, 'club_id').map { |s| s['user_id'] }
    @players = Round.where(club_id: @club.id).includes(:user).limit(100).map(&:user)

    if @users.size > USERS_COUNT_TO_SHOW
      @club_users = @club.users.find(@users).limit(USERS_COUNT_TO_SHOW)
      @extra_users_count = @users.size - USERS_COUNT_TO_SHOW
    else
      @club_users = @club.users.find(@users)
      @extra_users_count = false
    end
  end

  def search
    @clubs = Club.search params[:query], operator: 'or', fields: [:name], match: :word_middle, page: 0, per_page: 5
    render layout: false
  end

  def cover; end

  def logo; end

  def delete_logo
    @club.logo.purge_later
    redirect_to @club
  end

  def delete_cover
    @club.cover.purge_later
    redirect_to @club
  end

  def update_logo
    decoded_data = Base64.decode64(club_params[:logo].split(',')[1])
    @club.logo = {
      io: StringIO.new(decoded_data),
      content_type: 'image/png',
      filename: "club-logo-#{@club.id}.png"
    }
    @club.save
    redirect_to @club
  end

  def update_cover
    decoded_data = Base64.decode64(club_params[:cover].split(',')[1])
    @club.cover = {
      io: StringIO.new(decoded_data),
      content_type: 'image/png',
      filename: "club-cover-#{@club.id}.png"
    }
    @club.save
    redirect_to @club
  end

  private

  def check_if_moderator
    @club = Club.find(params[:club_id])
    unless current_user.has_role?(:moderator, @club)
      render file: "#{Rails.root}/public/403.html", status: :forbidden, layout: false
    end
  end

  def club_params
    params.require(:club).permit(:logo, :cover)
  end
end
