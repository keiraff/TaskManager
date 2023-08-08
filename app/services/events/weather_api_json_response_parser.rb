# frozen_string_literal: true

module Events
  class WeatherApiJsonResponseParser < ApplicationService
    attr_reader :event, :data

    def initialize(event, data)
      @event = event
      @data = data
    end

    def call
      weather_object = weather_from_parsed_data

      if weather_object
        success(weather_object)
      else
        failure("Can't show forecast for this event.")
      end
    end

    private

    def weather_from_parsed_data
      time = event.starts_at.hour

      return if data_invalid?(time)

      parsed_data = JSON.parse(data.to_json, symbolize_names: true)[:hourly]

      Weather.new(parsed_data[:temperature_2m][time], parsed_data[:precipitation_probability][time],
                  parsed_data[:weathercode][time], parsed_data[:is_day][time])
    end

    def data_invalid?(time)
      data["hourly"]["weathercode"][time].blank?
    end
  end
end
