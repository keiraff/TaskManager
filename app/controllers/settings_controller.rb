# frozen_string_literal: true

class SettingsController < AuthenticatedController
  def edit
    user
  end

  def update
    if user.update(settings_params)
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

  def settings_params
    params.require(:user).permit(:time_zone)
  end
end
