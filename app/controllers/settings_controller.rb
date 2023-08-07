# frozen_string_literal: true

class SettingsController < AuthenticatedController
  def edit; end

  def update
    if current_user.update(settings_params)
      flash[:success] = "Time zone is updated!"
      redirect_to current_user
    else
      flash.now[:danger] = "Something went wrong :("
      render "edit"
    end
  end

  private

  def settings_params
    params.require(:user).permit(:time_zone)
  end
end
