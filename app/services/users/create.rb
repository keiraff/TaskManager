# frozen_string_literal: true

module Users
  class Create < ApplicationService
    DEFAULT_CATEGORIES_NAMES = ["Personal", "Work", "Vacation"].freeze

    attr_reader :params, :user

    def initialize(params)
      @params = params
    end

    def call
      self.user = User.new(params)

      user.categories.new(DEFAULT_CATEGORIES_NAMES.map { |name| { name: name } })

      if user.save
        success(user)
      else
        failure(user.errors.full_messages)
      end
    end

    private

    attr_writer :user
  end
end
