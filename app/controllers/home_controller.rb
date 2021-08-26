# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @home = 'home'
    @article = Article.order('created_at desc').first

    # following_ids = current_user.following_users.map(&:id)
    # Post.where(user_id: following_ids).order("created_at DESC").paginate(page: params[:page])

    if params[:tag]
      @tag = params[:tag]
      @posts = Post.tagged_with(params[:tag])
                   .includes(user: [avatar_attachment: :blob])
                   .includes([:club])
                   .order('created_at desc')
                   .page(params[:page]).per(50)
    else
      @posts = Post.includes(user: [avatar_attachment: :blob])
                   .includes([:club])
                   .order('created_at desc')
                   .page(params[:page]).per(50)
    end
    @user = current_user

    top_scores = Merit::Score.top_scored(since: Date.yesterday)
    users = User.includes([:sash]).find(top_scores.map { |s| s['user_id'] })

    items = top_scores.map do |ts|
      user = users.find { |u| u.id.to_s == ts['user_id'].to_s }
      avatar = user.avatar.attached? ? Rails.application.routes.url_helpers.rails_blob_url(user.avatar, Rails.application.config.action_mailer.default_url_options) : ""
      LeaderboardItem.new(id: user.id, position: 0, name: user.name, avatar: avatar, sum_points: ts['sum_points'])
    end

    @leaderboard_users = StandardCompetitionRanking.new(items, rank_by: :sum_points, sort_direction: :desc).calculate

    @polls = Poll.active.order(:created_at).limit(3).all
    @popular_tags = ActsAsTaggableOn::Tag.most_used(10)
  end
end
