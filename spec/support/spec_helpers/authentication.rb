# frozen_string_literal: true

module SpecHelpers
  module Authentication
    def login(user)
      user_cookies = ActionDispatch::Request.new(Rails.application.env_config.deep_dup).cookie_jar
      user_cookies.encrypted[:user_id] = user.id
      cookies[:user_id] = user_cookies[:user_id]
    end
  end
end
