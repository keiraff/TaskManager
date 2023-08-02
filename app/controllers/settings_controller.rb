# frozen_string_literal: true

class SettingsController < AuthenticatedController
  def edit
    user
  end

  def update
    if time_zone_valid?
      user.update_attribute(:time_zone, settings_params[:time_zone])
      flash[:success] = "Time zone is updated!"
      redirect_to current_user
    else
      flash.now[:danger] = "Something went wrong :("
      render "edit"
    end
  end

  private

  def user
    @user = current_user
  end

  def time_zone_valid?
    user.time_zone = settings_params[:time_zone]
    user.valid?(:time_zone)
    user.errors[:time_zone].blank?
  end

  def settings_params
    params.require(:user).permit(:time_zone)
  end
end
