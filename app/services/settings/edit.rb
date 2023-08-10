# frozen_string_literal: true

module Settings
  class Edit < ApplicationService
    attr_reader :country, :state

    def initialize(country, state)
      @country = country
      @state = state
    end

    def call
      states if country.present?
      cities if state.present?

      success({ cities: cities, states: states })
    end

    private

    attr_writer :cities, :states

    def states
      @states ||= CS.states(country)
    end

    def cities
      @cities ||= CS.cities(state, country)
    end
  end
end
