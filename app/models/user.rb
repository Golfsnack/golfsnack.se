class User < ApplicationRecord
  rolify
  has_merit

  acts_as_voter
  acts_as_followable
  acts_as_follower

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         # :lastseenable (Create own events instead?)
         # :confirmable, TODO: Activate when we don't invite specific users
         # :trackable (Create own events instead?)

  attr_accessor :invite_code
  validate :invite_code_valid, on: :create
  validates :email, email: true
  validates :first_name, :last_name, :golf_id, presence: true, on: :update
  validates :golf_id, length: { is: 10 }, format: { with: /\A[a-z\d]{6}-[a-z\d]{3}/i }, on: :update

  belongs_to :club, optional: true, counter_cache: true
  has_many :posts
  has_many :comments

  mount_uploader :avatar, AvatarUploader

  def invite_code_valid
    invite = Invitation.where(email: self.email, code: self.invite_code).first
    errors.add(:invite_code, :invalid) unless invite
  end

  def name
    first_name + " " + last_name
  end

  def email=(value)
    write_attribute(:email, value.strip.downcase) if value
  end

  def completed_profile?
    self.first_name.present? && self.last_name.present? && self.golf_id.present?
  end
end
