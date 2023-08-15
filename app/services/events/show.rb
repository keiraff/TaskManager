# frozen_string_literal: true

module Events
  class Show < ApplicationService
    attr_reader :event, :user

    def initialize(event, user)
      @event = event
      @user = user
    end

    def call
      result = Weather::ApiRequestService.call(event, user)

      if result.success?
        result = Weather::ApiResponseParser.call(event, result.value)

        if result.success?
          success(result.value)
        else
          failure(result.errors)
        end
      else
        failure(result.errors)
      end
    end
  end
end
