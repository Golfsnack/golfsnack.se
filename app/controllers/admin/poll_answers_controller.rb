module Admin
  class PollAnswersController < BaseController


    def index
      @poll = Poll.includes([:poll_questions, :poll_answers]).find(params[:poll_id])
      @poll_questions = @poll.poll_questions
      @poll_answers = @poll.poll_answers
    end

    private

    def poll_answer_params
      params.require(:poll_answer)
    end
  end
end
