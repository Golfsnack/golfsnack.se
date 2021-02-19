class Post < ApplicationRecord

  has_many_attached :images

  acts_as_commentable
  acts_as_votable
  acts_as_taggable_on :tags

  belongs_to :user
  belongs_to :club, counter_cache: true, optional: true
  validates :title, :body, presence: true

  has_rich_text :body

  has_one_attached :mainimage

  has_many_attached :images do |attachable|
    attachable.variant :thumb, resize: "200x100"
  end

  def name
    self.title
  end
end
