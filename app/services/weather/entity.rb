# frozen_string_literal: true

module Weather
  class Entity
    attr_accessor :temperature, :precipitation, :weather_code, :image,
                  :description, :is_day

    def initialize(temperature, precipitation, weather_code, is_day)
      @temperature = temperature
      @precipitation = precipitation
      @weather_code = weather_code
      @is_day = day_or_night(is_day)
      @description = description_from_weather_code
      @image = image_from_weather_code
    end

    def description_from_weather_code
      WEATHER_CODE_DESCRIPTIONS[weather_code.to_s][is_day]["description"]
    end

    def image_from_weather_code
      WEATHER_CODE_DESCRIPTIONS[weather_code.to_s][is_day]["image"]
    end

    def day_or_night(is_day_code)
      return "night" if is_day_code.to_i.zero?

      "day"
    end
  end
end
