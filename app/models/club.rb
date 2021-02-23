class Club < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :users
  has_many :posts

  searchkick word_middle: [:name], callbacks: :async

  accepts_nested_attributes_for :courses, reject_if: :all_blank, allow_destroy: true

  has_one_attached :cover
  has_one_attached :logo

  resourcify
  acts_as_followable

  attr_accessor :moderator_user_id
end
