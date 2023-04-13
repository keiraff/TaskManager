# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user, only: [:show], controller: :user
  end

  def current_user
    return unless session[:user_id]

    @user = User.find(session[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def log_in
    session[:user_id] = @user.id
  end

  def log_out
    session[:user_id] = nil
  end

  def authenticate_user
    redirect_to new_session_url unless logged_in?
  end
end
