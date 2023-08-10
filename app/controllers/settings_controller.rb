# frozen_string_literal: true

class SettingsController < AuthenticatedController
  def edit
    return unless request.xhr?

    result = Settings::Edit.call(params[:country], params[:state])

    respond_to do |format|
      format.json do
        render json: { states: result.value[:states], cities: result.value[:cities] }
      end
    end
  end

  def update
    if current_user.update(settings_params)
      flash[:success] = "Information is updated!"
      redirect_to current_user
    else
      flash.now[:danger] = "Something went wrong :("
      render "edit"
    end
  end

  private

  def settings_params
    params.require(:user).permit(:time_zone, :country, :state, :city)
  end
end
