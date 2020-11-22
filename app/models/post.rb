class Post < ApplicationRecord

  has_many_attached :images

  include Shared::Callbacks

  acts_as_commentable
  acts_as_votable

  belongs_to :user
  belongs_to :club, counter_cache: true
  validates :title, :body, presence: true
  has_rich_text :body

  def name
    self.title
  end
end
