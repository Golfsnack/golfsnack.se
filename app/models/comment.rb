# frozen_string_literal: true

class Comment < ApplicationRecord
  include Discard::Model
  include ActsAsCommentable::Comment
  include PublicActivity::Model
  tracked
  # include Mention

  belongs_to :commentable, polymorphic: true
  counter_culture :commentable

  default_scope -> { order('created_at ASC') }
  scope :kept, -> { undiscarded.joins(:commentable).merge(commentable.kept) }

  def kept?
    undiscarded? && commentable.kept?
  end

  acts_as_votable

  belongs_to :user

  validates :comment, presence: true
  validates :commentable, presence: true
  validates :user, presence: true
end
