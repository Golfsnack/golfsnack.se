class Post < ApplicationRecord
  include Shared::Callbacks

  include PublicActivity::Model
  tracked only: [:create, :like], owner: proc { |_controller, model| model.user }

  acts_as_commentable
  acts_as_votable

  belongs_to :user
  validates :title, :body, presence: true
  has_rich_text :body

  def name
    self.title
  end
end
