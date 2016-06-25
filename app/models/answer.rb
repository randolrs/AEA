class Answer < ActiveRecord::Base
	has_many :question_responses
end
