# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_likeable

  def create
    @likeable.liked_by current_user
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("#{@likeable.class}-#{@likeable.id}-reactions",
                                                  partial: 'shared/reactions', locals: { item: @likeable, animate: 'boop' })
      end
      format.html do
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def destroy
    @likeable.disliked_by current_user
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("#{@likeable.class}-#{@likeable.id}-reactions",
                                                  partial: 'shared/reactions', locals: { item: @likeable, animate: 'boop' })
      end
      format.html do
        redirect_back(fallback_location: root_path)
      end
    end
  end

  private

  def find_likeable
    @likeable_type = params[:likeable_type].classify
    @likeable = @likeable_type.constantize.find(params[:likeable_id])
  end
end
