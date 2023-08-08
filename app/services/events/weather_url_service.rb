# frozen_string_literal: true

module Events
  class WeatherUrlService < ApplicationService
    BASE_URL = "https://api.open-meteo.com/v1/forecast"
    WEATHER_PARAMETERS = ["temperature_2m", "precipitation_probability", "weathercode", "is_day"].freeze

    attr_reader :user, :event

    def initialize(user, event)
      @user = user
      @event = event
    end

    def call
      request_url = set_request_url

      if request_url
        success(request_url)
      else
        failure("Can't show forecast for this event. Specify your location in Settings.")
      end
    end

    private

    def set_request_url
      return if user.city_name.blank?

      coordinates = coordinates_of_city(user.city_name)

      params = {
        hourly: WEATHER_PARAMETERS.join(","),
        start_date: event.starts_at.to_date.iso8601,
        end_date: event.starts_at.to_date.iso8601,
        latitude: coordinates[0],
        longitude: coordinates[1],

      }
      "#{BASE_URL}?#{params.to_query}"
    end

    def coordinates_of_city(city)
      Geocoder.search(city).first.coordinates
    end
  end
end
