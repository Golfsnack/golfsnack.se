# frozen_string_literal: true

class Course < ApplicationRecord
  belongs_to :club
  counter_culture :club
  has_many :holes, dependent: :destroy

  accepts_nested_attributes_for :holes, reject_if: :all_blank, allow_destroy: true
end
