# frozen_string_literal: true

class LeaderboardController < ApplicationController
  def index
    top_scores = Merit::Score.top_scored
    users = User.includes([:sash]).find(top_scores.map { |s| s['user_id'] })

    items = top_scores.map do |ts|
      user = users.find { |u| u.id.to_s == ts['user_id'].to_s }
      LeaderboardItem.new(id: user.id, position: 0, name: user.name, avatar: user.avatar, sum_points: ts['sum_points'], posts_count: user.posts_count)
    end

    @users = StandardCompetitionRanking.new(items, rank_by: :sum_points, sort_direction: :desc).calculate
  end
end
