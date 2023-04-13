# frozen_string_literal: true

class UsersController < AuthenticationController
  def show
    @user = current_user
  end
end
