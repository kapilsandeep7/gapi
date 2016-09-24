class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  def current_user
	  @current_user ||= User.find_by(id: session[:user_id])
  end

  def check_login
      if !current_user
          redirect_to root_path
      end 
  end
  
  def check_user
  #User.find_by_id(current_user.id).update_attributes(:role =>true)
      if current_user.role != 1 
          redirect_to root_path
      end 
  end

	helper_method :current_user

end
