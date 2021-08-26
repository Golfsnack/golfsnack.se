# frozen_string_literal: true

module Golfsnack
  class CurrentUser < Grape::API
    resource :current_user do
      desc 'Return current user'
      get '' do
        current_user
      end
    end
  end
end
