# frozen_string_literal: true

module Weather
  class ApiRequestService < ApplicationService
    BASE_URL = "https://api.open-meteo.com/v1/forecast"
    WEATHER_PARAMETERS = ["temperature_2m", "precipitation_probability", "weathercode", "is_day"].freeze

    attr_reader :user, :event

    def initialize(event, user)
      @user = user
      @event = event
    end

    def call
      if request_url
        response = request_to_weather_api(request_url)
        if response[:status] == 200
          success(response[:data])
        else
          failure("Can't show forecast for this event. API request error.")
        end
      else
        failure("Can't show forecast for this event. Specify your location in Settings.")
      end
    end

    private

    def request_to_weather_api(url)
      connection = Faraday.new { |f| f.response :json }
      response = connection.get(url)
      { status: response.status, data: response.body }
    end

    def request_url
      return if user.city.blank?

      coordinates = city_coordinates

      params = {
        hourly: WEATHER_PARAMETERS.join(","),
        start_date: event.starts_at.to_date.iso8601,
        end_date: event.starts_at.to_date.iso8601,
        latitude: coordinates[0],
        longitude: coordinates[1],

      }
      "#{BASE_URL}?#{params.to_query}"
    end

    def city_coordinates
      results = Geocoder.search(user.city, params: { countrycodes: user.country })

      (result_from_correct_state(results) || results.first).coordinates
    end

    def result_from_correct_state(results)
      results.find { |value| value.data["address"]["state"] == state } if results.count > 1
    end

    def state
      @state ||= CS.states(user.country)[user.state.to_sym]
    end
  end
end
