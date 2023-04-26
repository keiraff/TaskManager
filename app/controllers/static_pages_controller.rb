# frozen_string_literal: true

class StaticPagesController < AuthenticationController
  def home
    render "home"
  end
end
