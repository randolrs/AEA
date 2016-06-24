class PagesController < ApplicationController

	def home

		if user_signed_in?

			if current_user.basic_profile

			else

				@hide_menu = true

			end

		else

		end

	end


end


