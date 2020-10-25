class Post < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  belongs_to :user
  validates :title, :body, presence: true
  has_rich_text :body


  def name
    self.title
  end
end
