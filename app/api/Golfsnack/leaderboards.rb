# frozen_string_literal: true
require 'standard_competition_ranking'

module Golfsnack
  class Leaderboards < Grape::API

    resource :leaderboards do
      desc 'Return leaderboard'
      get '' do
        top_scores = Merit::Score.top_scored(since: Date.yesterday)
        users = User.includes([:sash]).find(top_scores.map { |s| s['user_id'] })

        items = top_scores.map do |ts|
          user = users.find { |u| u.id.to_s == ts['user_id'].to_s }
          avatar = user.avatar.attached? ? Rails.application.routes.url_helpers.rails_blob_url(user.avatar, Rails.application.config.action_mailer.default_url_options) : ""
          LeaderboardItem.new(id: user.id, position: 0, name: user.name, avatar: avatar, sum_points: ts['sum_points'])
        end

        StandardCompetitionRanking.new(items, rank_by: :sum_points, sort_direction: :desc).calculate
      end
    end
  end
end
