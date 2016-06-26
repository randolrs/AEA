class PagesController < ApplicationController

	def home

		if params[:question_id]

			@question_show = Question.find(params[:question_id])
		end

		if user_signed_in?

			@user = current_user

			if @user.next_question.nil?

				five_minutes_from_now = Time.now + 3*60
				@user.update(:next_question => five_minutes_from_now)

			else

				unless params[:question_id]

					if Time.now > @user.next_question


						@show_user_question = Question.last


					end
				end

			end

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


