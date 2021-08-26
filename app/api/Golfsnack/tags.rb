# frozen_string_literal: true

module Golfsnack
  class Tags < Grape::API
    resource :tags do
      desc 'Return popular tags'
      params do
        optional :limit, type: Integer, desc: 'Limit (Default 10)'
      end
      get '' do
        ActsAsTaggableOn::Tag.most_used(params[:limit] || 10)
      end
    end
  end
end
