# frozen_string_literal: true

class SessionsController < AuthenticationController
  def new; end

  def create
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      log_in
      flash[:notice] = "Authorized"
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
