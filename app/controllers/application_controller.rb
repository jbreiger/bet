class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    
protect_from_forgery with: :exception
def user
  if [:user_id] 
  	return @signedin= User.find(:session[:user_id]).id
  end
end
end
