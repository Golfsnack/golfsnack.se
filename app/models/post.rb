class Post < ApplicationRecord
  belongs_to :user
  validates :title, :body, presence: true
  has_rich_text :body
end
