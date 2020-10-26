class Friendship < ApplicationRecord
  include Shared::Callbacks

  include PublicActivity::Model
  tracked only: [:create], owner: Proc.new{ |controller, model| model.friend }

  validates :friend, :user, presence: true

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  # def block!
  #   self.update_attribute(:blocked, true)
  # end
end
