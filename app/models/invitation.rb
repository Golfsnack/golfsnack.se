# frozen_string_literal: true

class Invitation < ApplicationRecord
  belongs_to :user, optional: true

  validates :code, presence: true
  validates :email, email: true

  def email=(value)
    self[:email] = value.strip.downcase if value
  end
end
