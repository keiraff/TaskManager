# frozen_string_literal: true

class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(create_params)
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
