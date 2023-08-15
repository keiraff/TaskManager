# frozen_string_literal: true

module Weather
  class Load < ApplicationService
    BASE_URL = "https://api.open-meteo.com/v1/forecast"
    WEATHER_PARAMETERS = ["temperature_2m", "precipitation_probability", "weathercode", "is_day"].freeze

    attr_reader :city, :state_code, :country_code, :date, :all_day

    def initialize(city:, state_code:, country_code:, date:, all_day: false)
      @city = city
      @state_code = state_code
      @country_code = country_code
      @date = date
      @all_day = all_day
    end

    def call
      return failure("Can't show forecast for this event. Specify your location in Settings.") if request_url.blank?

      response = HTTP.headers(access: "application/json").get(request_url)

      return failure("Can't show forecast for this event. API request error.") unless response.code == 200

      weather = weather_from_response_data(response.to_s)
      weather ? success(weather) : failure("Can't show forecast for this event.")
    end

    private

    def request_url
      return if city.blank?

      coordinates = city_coordinates

      params = {
        hourly: WEATHER_PARAMETERS.join(","),
        start_date: date.to_date.iso8601,
        end_date: date.to_date.iso8601,
        latitude: coordinates[0],
        longitude: coordinates[1],

      }
      "#{BASE_URL}?#{params.to_query}"
    end

    def city_coordinates
      (result_from_correct_state(geocoder_results) || geocoder_results.first).coordinates
    end

    def geocoder_results
      @geocoder_results ||= Geocoder.search(city, params: { countrycodes: country_code })
    end

    def result_from_correct_state(results)
      results.find { |value| value.data["address"]["state"] == state } if results.count > 1
    end

    def state
      @state ||= CS.states(country_code)[state_code.to_sym]
    end

    def weather_from_response_data(response_data)
      hour = event_starts_at_hour
      parsed_data = JSON.parse(response_data, symbolize_names: true)[:hourly]

      return if data_invalid?(parsed_data, hour)

      Weather::Entity.new(parsed_data, hour)
    end

    def data_invalid?(response_data, hour)
      response_data[:weathercode][hour].blank?
    end

    def event_starts_at_hour
      all_day ? 12 : date.hour
    end
  end
end
