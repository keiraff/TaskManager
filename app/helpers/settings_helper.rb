# frozen_string_literal: true

module SettingsHelper
  def country_options_for_select(selected_option = selected_country)
    options_for_select(CS.countries.except(:COUNTRY_ISO_CODE).map do |iso_code, name|
      [name, iso_code]
    end.sort, selected_option)
  end

  def selected_country
    return unless current_user.country

    current_user.country
  end

  def state_options_for_select(country, selected_option = selected_state)
    country.present? ? options_for_select(CS.states(country).map { |key, name| [name, key] }.sort, selected_option) : {}
  end

  def selected_state
    return unless current_user.state

    current_user.state
  end

  def city_options_for_select(state, country, selected_option = selected_city)
    state.present? ? options_for_select(CS.cities(state, country), selected_option) : {}
  end

  def selected_city
    return unless current_user.city

    current_user.city
  end
end
