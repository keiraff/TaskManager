# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  include Authentication
  include Pundit::Authorization

  before_action :authenticate_user

  rescue_from Pundit::NotAuthorizedError do
    flash[:danger] = "Editing past events isn't allowed."
    redirect_to(request.referer || events_url)
  end
end
