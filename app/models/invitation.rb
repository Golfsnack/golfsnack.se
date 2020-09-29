class Invitation < ApplicationRecord
  validates :email, :code, presence: true

  belongs_to :user, optional: true
end
