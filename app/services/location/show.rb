# frozen_string_literal: true

module Location
  class Show < ApplicationService
    attr_reader :country, :state

    def initialize(country:, state: nil)
      @country = country
      @state = state
    end

    def call
      success({ cities: cities, states: states })
    end

    private

    attr_writer :cities, :states

    def states
      return if country.blank?

      @states ||= CS.states(country)
    end

    def cities
      return if state.blank? && country.blank?

      @cities ||= CS.cities(state, country)
    end
  end
end
