class PollQuestion < ApplicationRecord
  belongs_to :poll
  has_many :poll_answers

  validates :choice, presence: true
end
