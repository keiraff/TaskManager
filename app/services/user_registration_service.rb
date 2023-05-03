# frozen_string_literal: true

class UserRegistrationService < ApplicationService
  DEFAULT_CATEGORIES_NAMES = ["Personal", "Work", "Vacation"].freeze

  def initialize(params)
    @params = params
  end

  def call
    @user = User.new(@params)

    DEFAULT_CATEGORIES_NAMES.each do |name|
      @user.categories.new(name: name)
    end

    if @user.save
      success(@user)
    else
      failure(@user)
    end
  end
end
