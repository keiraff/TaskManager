# frozen_string_literal: true

class StaticPagesController < AuthenticationController

  def home
    render template: params[:page].to_s
  end
end
