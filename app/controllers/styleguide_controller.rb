class StyleguideController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    first_comment = Comment.new(user: User.first, created_at: Time.now, comment: "This is awesome!")
    first_comment.liked_by User.last
    second_comment = Comment.new(user: User.last, created_at: Time.now - 1.day, comment: "I know right!")
    @comments = [first_comment, second_comment]
  end
end
