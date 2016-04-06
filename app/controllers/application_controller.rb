class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

 def require_login
   redirect_to new_user_session_path unless user_signed_in?
 end
end
