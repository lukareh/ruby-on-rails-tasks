# controller for user profile settings
class SettingsController < ApplicationController
  before_action :authenticate_user!

  # show settings form
  def edit
    @user = current_user
  end

  # update user settings (password and avatar only)
  def update
    @user = current_user
    
    if user_params[:password].present?
      # password change requested
      if @user.update_with_password(user_params)
        bypass_sign_in(@user)
        redirect_to root_path, notice: 'settings updated successfully'
      else
        render :edit
      end
    elsif user_params[:avatar].present?
      # only avatar update
      if @user.update(avatar: user_params[:avatar])
        redirect_to edit_settings_path, notice: 'profile picture updated'
      else
        render :edit
      end
    else
      redirect_to edit_settings_path, alert: 'no changes made'
    end
  end

  private

  # permit only password and avatar
  def user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation, :avatar)
  end
end
