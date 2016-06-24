class PagesController < ApplicationController

	def home

		if user_signed_in?

			@user = current_user

			if current_user.basic_profile

				@question = Question.new

			else

				@hide_menu = true

			end

		else

		end

	end

	def update_basic_profile

		if user_signed_in?

			if params[:birth_year]

				current_user.update(:birth_year => params[:birth_year])

			end


			if params[:gender]

				current_user.update(:gender => params[:gender])


			end

			if current_user.birth_year && current_user.gender

				current_user.update(:basic_profile => true)

			end

		end

		redirect_to root_path

	end


end


