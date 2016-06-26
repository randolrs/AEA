class Question < ActiveRecord::Base
	belongs_to :user
	has_many :answers
	has_many :question_responses
	has_many :responses
  	accepts_nested_attributes_for :answers, allow_destroy: true
end
