
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_commentable, only: :create

  def create
    @comment = @commentable.comments.new do |comment|
      comment.comment = params[:comment_text]
      comment.user = current_user
    end
    @comment.save
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.append("comments-#{@commentable.id}", partial: "comments/comment", locals: { comment: @comment})
      end
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment_id = params[:id]
    @comment.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@comment) }
      format.html { redirect_back(fallback_location: root_path) }
    end
  end

  private
  def find_commentable
    @commentable_type = params[:commentable_type].classify
    @commentable = @commentable_type.constantize.find(params[:commentable_id])
  end
end
