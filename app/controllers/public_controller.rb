# frozen_string_literal: true

class PublicController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'application'

  def useragreement; end

  def faq; end

  def about_us; end

  def shop; end
end
