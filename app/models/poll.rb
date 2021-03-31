# frozen_string_literal: true

class Poll < ApplicationRecord
  has_many :poll_questions
  has_many :poll_answers

  validates :name, presence: true, length: { minimum: 3 }
  validates :poll_questions, presence: true, length: { minimum: 2 }

  accepts_nested_attributes_for :poll_questions, allow_destroy: true

  scope :active, -> { where.not(archived: true) }
end
