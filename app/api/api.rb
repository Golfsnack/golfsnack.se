# frozen_string_literal: true
require 'grape-swagger'

class API < Grape::API
  version 'v1', using: :path
  prefix 'api'
  default_format :json
  format :json
  formatter :json, Grape::Formatter::ActiveModelSerializers

  helpers do
    def permitted_params
      @permitted_params ||= declared(params, include_missing: false)
    end

    def logger
      Rails.logger
    end

    def current_user
      @current_user ||= User.first
    end

    def authenticate!
      error!('401 Unauthenticated', 401) unless current_user
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    error_response(message: e.message, status: 404)
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    error_response(message: e.message, status: 422)
  end

  mount Golfsnack::Posts
  mount Golfsnack::Tags
  mount Golfsnack::Leaderboards
  mount Golfsnack::CurrentUser
  mount Golfsnack::Polls

  add_swagger_documentation
end
