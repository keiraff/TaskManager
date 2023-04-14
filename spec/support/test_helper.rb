# frozen_string_literal: true

module TestHelper
  def login(user)
    post sessions_url, params: { email: user.email, password: user.password }
  end

  def logout(user)
    delete session_url(user.id)
  end
end
