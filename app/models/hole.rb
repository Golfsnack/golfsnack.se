class Hole < ApplicationRecord
  belongs_to :course
  counter_culture :course
end
