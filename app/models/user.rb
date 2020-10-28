class User < ApplicationRecord
  has_merit

  has_merit
  acts_as_voter
  acts_as_followable
  acts_as_follower

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :lastseenable
         # :confirmable, TODO: Activate when we don't invite specific users

  attr_accessor :invite_code
  validates :first_name, :last_name, :golf_id, presence: true
  validate :invite_code_valid, on: :create
  validates :golf_id, length: { is: 10 }, format: { with: /\A[a-z\d]{6}-[a-z\d]{3}/i }

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
end
