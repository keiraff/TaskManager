# frozen_string_literal: true

class AuthenticationController < ApplicationController
  include Authentication

  helper_method :logged_in?, :current_user
end
