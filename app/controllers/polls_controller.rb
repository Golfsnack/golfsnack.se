class PollsController < ApplicationController
  before_action :authenticate_user!

  def vote
    if (poll_params[:poll_question_id])
      answer = PollAnswer.new(poll_params)
      answer.user = current_user
      answer.save!
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def poll_params
    params.require(:poll_answer).permit(:poll_id, :poll_question_id)
  end
end
