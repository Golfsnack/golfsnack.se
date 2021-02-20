class ClubsController < ApplicationController
   before_action :check_if_moderator, except: [:index, :show, :search]

  def index
    @clubs = Club.order('users_count DESC').order('posts_count DESC').order(:name).page params[:page]
  end

  def show
    @club = Club.find(params[:id])
  end

  def search
    @clubs = Club.search params[:query], operator: "or", fields: [:name], match: :word_middle, page: 0, per_page: 5
    render layout: false
  end

  def cover;end
  def logo;end

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
    if !current_user.has_role?(:moderator, @club)
      render :file => "#{Rails.root}/public/403.html", status: 403, layout: false
    end
  end

  def club_params
    params.require(:club).permit(:logo, :cover)
  end
end
