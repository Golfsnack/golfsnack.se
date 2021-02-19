module Admin
  class ClubsController < BaseController

    def new
      @club = Club.new
    end

    def edit
      @club = Club.find(params[:id])
      if @club.applied_roles.size > 0
        @club.moderator_user_id = @club.applied_roles.first.user_ids.first
      end
    end

    def index
      if params[:query]
        @clubs = Club.search params[:query], operator: "or", fields: [:name], match: :word_middle, page: params[:page]
      else
        @clubs = Club.page params[:page]
      end
    end

    def create
      @club = Club.new(club_params)
      if @club.save
        set_club_admin(club_params[:moderator_user_id])
        flash[:success] = "Golfklubb skapad"
        redirect_to admin_clubs_path
      else
        flash.now[:error] = "Något gick fel"
        render :new
      end
    end

    def update
      @club = Club.find(params[:id])
      if @club.update(club_params)
        set_club_admin(club_params[:moderator_user_id])
        flash[:success] = "Golfklubb uppdaterad"
        redirect_to admin_clubs_path
      else
        flash.now[:error] = "Något gick fel"
        render :edit
      end
    end

    private

    def set_club_admin(moderator_user_id)
      @club.roles.map(&:destroy)
      if moderator_user_id && moderator_user_id != ""
        user = User.find(moderator_user_id)
        user.grant :moderator, @club
      end
    end

    def club_params
      params.require(:club).permit(
        :name, :description, :lat, :lng, :moderator_user_id,
        courses_attributes: [:name, :par, :architect, :description, :_destroy, :id, :holes_count]
      )
    end
  end
end
