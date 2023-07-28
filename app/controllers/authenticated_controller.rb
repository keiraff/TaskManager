# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  include Authentication
  include Pundit::Authorization

  before_action :authenticate_user
end
