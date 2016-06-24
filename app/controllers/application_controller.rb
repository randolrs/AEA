class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  	if @need_login
  		before_action :authenticate_user!
	end

	def login
		@hide_menu = true
	end

end
