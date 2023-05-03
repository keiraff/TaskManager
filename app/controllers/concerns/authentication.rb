# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :logged_in?, :current_user
  end

  def current_user
    return if cookies.encrypted[:user_id].blank?

    @current_user ||= User.find(cookies.encrypted[:user_id])
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

  def redirect_to_user_page
    redirect_to current_user if logged_in?
  end
end
