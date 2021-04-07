# frozen_string_literal: true

module Admin
  class ClubsController < BaseController
    def new
      @club = Club.new
    end

    def edit
      @club = Club.find(params[:id])
      raise 'Not allowed' if !current_user.has_role?(:admin) && !current_user.has_role?(:moderator, @club)

      @url = if !current_user.has_role?(:admin) && current_user.has_role?(:moderator, @club)
               club_admin_path(@club)
             else
               admin_club_path(@club)
             end
      @club.moderator_user_id = @club.applied_roles.first.user_ids.first if @club.applied_roles.size.positive?
    end

    def index
      @clubs = if params[:query]
                 Club.search params[:query], operator: 'or', fields: [:name], match: :word_middle, page: params[:page]
               else
                 Club.page params[:page]
               end
    end

    def create
      @club = Club.new(club_params)
      if @club.save
        set_club_admin(club_params[:moderator_user_id])
        flash[:success] = 'Golfklubb skapad'
        redirect_to admin_clubs_path
      else
        flash.now[:error] = 'Något gick fel'
        render :new
      end
    end

    def update
      @club = Club.find(params[:id])
      raise 'Not allowed' if !current_user.has_role?(:admin) && !current_user.has_role?(:moderator, @club)

      if @club.update(club_params)
        set_club_admin(club_params[:moderator_user_id]) unless club_params[:moderator_user_id].nil?
        flash[:success] = 'Golfklubb uppdaterad'
        if current_user.has_role?(:moderator, @club)
          redirect_to club_admin_path(@club)
        else
          redirect_to admin_clubs_path
        end
      else
        flash.now[:error] = 'Något gick fel'
        render :edit
      end
    end

    private

    def set_club_admin(moderator_user_id)
      @club.roles.map(&:destroy)
      if moderator_user_id && moderator_user_id != ''
        user = User.find(moderator_user_id)
        user.grant :moderator, @club
      end
    end

    def club_params
      params.require(:club).permit(
        :name, :description, :lat, :lng, :moderator_user_id,
        courses_attributes: %i[name par architect description _destroy id holes_count]
      )
    end
  end
end
