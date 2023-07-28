# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  include Authentication
  include Pundit::Authorization

  before_action :authenticate_user

  rescue_from Pundit::NotAuthorizedError do |error|
    flash[:danger] = error.policy.error_message
    redirect_to(request.referer || events_url)
  end
end
