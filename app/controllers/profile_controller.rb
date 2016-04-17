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
    else
      render :edit
    end
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update_with_password(password_params)
      sign_in @user, :bypass => true
      flash[:notice] = t('profile.password_changed')
    else
      @user.errors.messages.each do |type, msg|
        flash[type] = msg[0]  
      end
    end
    respond_to(&:js)
  end

  private

  def user_params
    params.require(:current_user).permit(:username, :phone)
  end
  
  def password_params
    params.require(:current_user).permit(:password, :password_confirmation, :current_password)
  end
  
  def require_login
    redirect_to new_user_session_path unless user_signed_in?
  end
  
end
