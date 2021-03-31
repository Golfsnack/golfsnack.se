# frozen_string_literal: true

class Article < ApplicationRecord
  extend FriendlyId
  belongs_to :category
  counter_culture :category

  has_one_attached :image
  has_rich_text :body
  friendly_id :title, use: :slugged

  validates :title, :image, :body, :category, presence: true

  def read_minutes
    body_in_database ? body_in_database.scan(/\w+/).size / 275 : 3
  end
end
