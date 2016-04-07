class ProfileController < ApplicationController

  before_action :require_login

  def index
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_profile_path
    end
  end

  private

  def user_params
    params.require(:current_user).permit(:username,:phone)
  end
end
