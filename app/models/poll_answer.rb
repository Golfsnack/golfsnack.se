class PollAnswer < ApplicationRecord
  belongs_to :poll
  counter_culture :poll
  belongs_to :user
  belongs_to :poll_question

  include PublicActivity::Model
  tracked

  validates :user, presence: true
  validates :poll, presence: true
  validates :poll_question, presence: true
end
