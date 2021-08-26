class LeaderboardItem < ActiveModelSerializers::Model
  # include ActiveModel::Model

  attr_accessor :id, :position, :sum_points, :name, :avatar, :posts_count
end
