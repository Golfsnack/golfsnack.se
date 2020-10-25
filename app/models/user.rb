class User < ApplicationRecord
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

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  mount_uploader :avatar, AvatarUploader

  def invite_code_valid
    invite = Invitation.where(email: self.email, code: self.invite_code).first
    errors.add(:invite_code, :invalid) unless invite
  end

  def name
    first_name + " " + last_name
  end

  def role
    "Tiger Woods"
  end
end
