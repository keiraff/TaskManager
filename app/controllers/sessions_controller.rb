# frozen_string_literal: true

class SessionsController < AuthenticationController
  def new; end

  def create
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      log_in
      redirect_to @user
    else
      redirect_to login_url
    end
  end

  def destroy
    log_out
    redirect_to login_url
  end
end
