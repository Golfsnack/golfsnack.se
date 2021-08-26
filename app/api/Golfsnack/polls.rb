# frozen_string_literal: true

module Golfsnack
  class Polls < Grape::API
    resource :polls do
      desc 'Return active polls'
      params do
        optional :limit, type: Integer, desc: 'Limit (Default 3)'
      end
      get '' do
        Poll.active.order(:created_at).limit(params[:limit] || 3).all
      end

      desc 'Return one poll'
      params do
        requires :id, type: Integer, desc: 'Id'
      end
      get ':id' do
        Poll.find(params[:id])
      end
    end
  end
end
