# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'mulligan@golfsnack.se'
  layout 'mailer'
end
