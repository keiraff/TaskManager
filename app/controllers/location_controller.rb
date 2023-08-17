# frozen_string_literal: true

class LocationController < AuthenticatedController
  def show
    result = Location::Show.call(**show_params.to_h.symbolize_keys)

    respond_to do |format|
      format.json do
        render json: { states: result.value[:states], cities: result.value[:cities] }
      end
    end
  end

  private

  def show_params
    params.permit(:country, :state)
  end
end
