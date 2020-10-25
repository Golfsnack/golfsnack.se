class Guide < ApplicationRecord
  extend FriendlyId

  has_one_attached :image
  has_rich_text :body
  friendly_id :title, use: :slugged

  validates :title, :image, :body, presence: true
end
