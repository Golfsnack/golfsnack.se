class PollAnswer < ApplicationRecord
  belongs_to :poll
  belongs_to :user
  belongs_to :poll_question

  validates :user, presence: true
  validates :poll, presence: true
  validates :poll_question, presence: true
end
