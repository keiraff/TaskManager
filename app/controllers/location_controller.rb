# frozen_string_literal: true

class LocationController < AuthenticatedController
  def get
    result = Location::Get.call(params[:country], params[:state])

    respond_to do |format|
      format.json do
        render json: { states: result.value[:states], cities: result.value[:cities] }
      end
    end
  end
end
