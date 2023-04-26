# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user, only: [:show], controller: :user
    before_action :redirect_to_user_page, only: [:new, :home], controller: [:registrations, :sessions, :static_pages]
  end

  def current_user
    return if cookies.encrypted[:user_id].blank?

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

  def redirect_to_user_page
    redirect_to @user if logged_in?
  end
end
