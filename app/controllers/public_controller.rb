class PublicController < ApplicationController
  skip_before_action :authenticate_user!
  layout "application"

  def useragreement
  end
end
