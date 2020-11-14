class Invitation < ApplicationRecord
  validates :code, presence: true
  validates :email, email: true

  belongs_to :user, optional: true

  def email=(value)
    write_attribute(:email, value.strip.downcase) if value
  end
end
