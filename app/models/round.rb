# frozen_string_literal: true

class Round < ApplicationRecord
  belongs_to :club
  belongs_to :user
end
