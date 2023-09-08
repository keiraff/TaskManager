# frozen_string_literal: true

class RegistrationsController < ApplicationController
  include Authentication

  before_action :redirect_to_user_page, only: [:new]

  def new
    @user = User.new
  end

  def create
    result = Users::Create.call(create_params)

    @user = result.user
    if result.success?
      log_in

      redirect_to @user
    else
      render "new"
    end
  end

  private

  def create_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
