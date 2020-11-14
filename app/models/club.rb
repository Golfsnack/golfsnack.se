class Club < ApplicationRecord
  has_many :courses, dependent: :destroy
  has_many :users
end
