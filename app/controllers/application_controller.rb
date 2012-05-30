class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def require_login
    redirect_to root_url, notice: "Nice try!" if session[:uid].nil?
  end
  
end
