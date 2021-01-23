module Admin
  class PollsController < BaseController

    def new
      @poll = Poll.new
      10.times do |i|
        @poll.poll_questions.build
      end
    end

    def edit
      @poll = Poll.find(params[:id])
      (10 - @poll.poll_questions.size).times do
        @poll.poll_questions.build
      end
    end

    def index
      @polls = Poll.all
    end

    def create
      @poll = Poll.new(param_clean(poll_params))
      if @poll.save
        flash[:success] = "Omröstning skapad"
        redirect_to admin_polls_path
      else
        flash.now[:error] = "Något gick fel"
        render :new
      end
    end

    def update
      @poll = Poll.find(params[:id])
      if @poll.update(param_clean(poll_params))
        flash[:success] = "Omröstning uppdaterad"
        redirect_to admin_polls_path
      else
        flash.now[:error] = "Något gick fel"
        render :edit
      end
    end

    private

    def poll_params
      params.require(:poll).permit(:name, poll_questions_attributes: [:id, :choice, :_destroy])
    end

    def param_clean(_params)
      _params.delete_if do |k, v|
        if v.instance_of?(ActionController::Parameters)
          param_clean(v)
        end
        v.empty?
      end
    end
  end
end
