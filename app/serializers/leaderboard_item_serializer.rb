# frozen_string_literal: true

class LeaderboardItemSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :position, :sum_points, :name, :avatar
end
