class Friendship < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  belongs_to :user
  belongs_to :friend, class_name: 'User'
end
