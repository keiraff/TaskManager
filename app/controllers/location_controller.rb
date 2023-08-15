# frozen_string_literal: true

class LocationController < AuthenticatedController
  def show
    result = Location::Show.call(country: permitted_params[:country], state: permitted_params[:state])

    respond_to do |format|
      format.json do
        render json: { states: result.value[:states], cities: result.value[:cities] }
      end
    end
  end

  private

  def permitted_params
    params.permit(:country, :state)
  end
end
