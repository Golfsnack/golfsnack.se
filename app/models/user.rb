# frozen_string_literal: true

class User < ApplicationRecord
  include Discard::Model
  rolify
  has_merit

  searchkick highlight: %i[first_name last_name], callbacks: :async

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
  validates :first_name, :last_name, presence: true, on: :update
  validates :golf_id, length: { is: 10 }, format: { with: /\A[a-z\d]{6}-[a-z\d]{3}/i }, on: :update, allow_blank: true

  belongs_to :club, optional: true
  counter_culture :club
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rounds, dependent: :destroy

  has_one_attached :cover
  has_one_attached :avatar

  def invite_code_valid
    invite = Invitation.where(email: email, code: invite_code).first
    errors.add(:invite_code, :invalid) unless invite
  end

  def name
    "#{first_name} #{last_name}"
  end

  def email=(value)
    self[:email] = value.strip.downcase if value
  end

  def completed_profile?
    first_name.present? && last_name.present?
  end

  def highest_role
    return nil unless roles

    order = %w[admin moderator premium ambassador verified]
    roles.min_by { |role| order.index role.name }
  end

  def active_for_authentication?
    super && !discarded?
  end

  def rounds_count
    0
  end
end
