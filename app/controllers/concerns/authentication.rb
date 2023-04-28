# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user, only: [:show], controller: :user
  end

  def current_user
    return if cookies[:user_id].blank?

    @user = User.find(cookies.encrypted[:user_id])
  end

  def logged_in?
    current_user.present?
  end

  def log_in
    cookies.encrypted[:user_id] = @user.id
  end

  def log_out
    cookies.delete(:user_id)
  end

  def authenticate_user
    redirect_to new_session_url unless logged_in?
  end
end
