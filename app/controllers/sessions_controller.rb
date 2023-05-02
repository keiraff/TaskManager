# frozen_string_literal: true

class SessionsController < ApplicationController
  include Authentication

  before_action :authenticate_user, only: [:destroy]
  before_action :redirect_to_user_page, only: [:new]

  def new; end

  def create
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      log_in

      flash[:notice] = "Authenticated"
      redirect_to @user
    else
      flash[:error] = "Email or password is incorrect"
      render "new"
    end
  end

  def destroy
    log_out

    redirect_to new_session_url
  end
end
