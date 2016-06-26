class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :questions
    has_many :question_responses
    has_many :responses

    def timeline_questions

    	@timeline_questions = Question.last(5).sort { |a,b| a.created_at <=> b.created_at }.reverse
    	
    	return @timeline_questions
    end
end
