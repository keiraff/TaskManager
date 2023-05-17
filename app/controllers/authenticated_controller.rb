# frozen_string_literal: true

class AuthenticatedController < ApplicationController
  include Authentication

  before_action :authenticate_user
end
