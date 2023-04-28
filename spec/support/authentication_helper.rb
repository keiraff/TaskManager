# frozen_string_literal: true

module AuthenticationHelper
  def login(user)
    my_cookies = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
    my_cookies.encrypted[:user_id] = user.id
    cookies[:user_id] = my_cookies[:user_id]
  end
end
