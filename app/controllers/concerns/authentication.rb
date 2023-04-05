# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  def current_user
    return unless session[:user_id]

    @user = User.find(session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def log_in
    session[:user_id] = @user.id
  end

  def log_out
    session[:user_id] = nil
  end

  def authorized
    redirect_to login_path unless logged_in?
  end
end
