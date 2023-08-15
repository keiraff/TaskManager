# frozen_string_literal: true

module Weather
  class ApiResponseParser < ApplicationService
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
      hour = event_starts_at_hour

      return if data_invalid?(hour)

      parsed_data = JSON.parse(data.to_json, symbolize_names: true)[:hourly]

      Weather::Entity.new(parsed_data[:temperature_2m][hour], parsed_data[:precipitation_probability][hour],
                          parsed_data[:weathercode][hour], parsed_data[:is_day][hour])
    end

    def data_invalid?(hour)
      data["hourly"]["weathercode"][hour].blank?
    end

    def event_starts_at_hour
      event.all_day? ? 12 : event.starts_at.hour
    end
  end
end
