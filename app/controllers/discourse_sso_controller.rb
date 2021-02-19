require 'single_sign_on'

class DiscourseSsoController < ApplicationController
  before_action :authenticate_user! # ensures user must login

  def sso
    secret = ENV['SSO_SECRET']
    sso = SingleSignOn.parse(request.query_string, secret)
    sso.email = current_user.email # from devise
    sso.name = current_user.name # this is a custom method on the User class
    sso.username = current_user.email # from devise
    sso.external_id = current_user.id # from devise
    if current_user.avatar.attached?
      sso.avatar_url = current_user.avatar
    end
    sso.sso_secret = secret

    redirect_to sso.to_url("http://forum.golfsnack.se/session/sso_login")
  end
end
