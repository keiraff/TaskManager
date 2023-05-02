# frozen_string_literal: true

class RegistrationsController < ApplicationController
  include Authentication

  before_action :redirect_to_user_page, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)

    DefaultCategoriesService.call(@user)

    if @user.save
      redirect_to new_session_url
    else
      render "new"
    end
  end

  private

  def create_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
