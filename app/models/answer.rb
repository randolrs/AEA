class Answer < ActiveRecord::Base
	has_many :question_responses
	has_many :responses
end
