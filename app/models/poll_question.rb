# frozen_string_literal: true

class PollQuestion < ApplicationRecord
  belongs_to :poll
  counter_culture :poll
  has_many :poll_answers, dependent: :destroy

  validates :choice, presence: true
end
