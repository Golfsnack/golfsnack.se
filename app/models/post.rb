class Post < ApplicationRecord
  include Discard::Model
  include PublicActivity::Model
  tracked

  has_many_attached :images

  acts_as_commentable
  acts_as_votable
  acts_as_taggable_on :tags

  belongs_to :user
  counter_culture :user

  belongs_to :club, optional: true
  counter_culture :club

  scope :kept, -> { undiscarded.joins(:user).merge(User.kept) }

  def kept?
    undiscarded? && user.kept?
  end

  validates :title, :body, presence: true

  has_rich_text :body

  has_one_attached :mainimage
  has_many_attached :images

  def name
    self.title
  end
end
