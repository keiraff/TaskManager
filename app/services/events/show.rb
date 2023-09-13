# frozen_string_literal: true

module Events
  class Show < ApplicationService
    attr_reader :event, :user

    def initialize(event, user)
      @event = event
      @user = user
    end

    def call
      result = Weather::Load.call(city: user.city, state_code: user.state, country_code: user.country,
                                  date: event.starts_at, all_day: event.all_day)

      result.success? ? success(result.value) : failure(result.errors)
    end
  end
end
