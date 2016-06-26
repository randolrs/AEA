class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    if params[:id]

      @question = Question.find(params[:id])
      redirect_to root_path(:question_id => @question.id) 
    else

      redirect_to root_path(:notice => "Cannot find question!") 
    end
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    @question.update(:user_id => current_user.id)

    respond_to do |format|
      if @question.save
        format.html { redirect_to root_path(:question_id => @question.id), notice: 'Question was successfully created.' }
        # format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        # format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def return_details


    if params[:question_id]

      if Question.exists?(id: params[:question_id])

        @question = Question.find(params[:question_id])
        body = @question.body

        notice = ""
        i = 0

        answer_array = Array.new

        @answers_html = ""

        total_responses_count_for_question = Response.where(:question_id => @question.id).count

        @question.answers.each do |answer|

          if total_responses_count_for_question > 0

            answer_responses_percentage = ((answer.responses.count / total_responses_count_for_question) * 100).to_i.to_s + "%"
          
          else

            answer_responses_percentage = "0%"
          end


          this_answer_html = %q(<br><div class="question-answer-field"><a class= "answer-field" style="width:) +   " id=" + answer.id.to_s + %q("><span class="answer-field-body">) + answer.body + %q(</span><span class="answer-field-percentage">) + answer_responses_percentage + "</span></a></div>"

          @answers_html = @answers_html + this_answer_html

        end

        respond_to do |format|
              format.js { render json: { :body => @question.body, :notice=> notice, :answers_html => @answers_html, :answers_count => @question.answers.count} , content_type: 'text/json' }
        end

      else

        respond_to do |format|
            format.js { render json: { :notice => "Question Not Found" } , content_type: 'text/json' }
        end

      end

    else

      respond_to do |format|
            format.js { render json: { :alert => "Question Not Found" } , content_type: 'text/json' }
      end

    end


  end

  def ajax_response

    if user_signed_in?

      if Question.exists?(id: params[:question_id]) && Answer.exists?(id: params[:answer_id])

        @question = Question.find(params[:question_id])

        @answer = Answer.find(params[:answer_id])

        @response = Response.new

        @response.update(:question_id => @question.id, :answer_id => @answer.id, :user_id =>current_user.id)

        @response.save

        respond_to do |format|
           
           if @response.save
              format.js { render json: { :successful => true, :notice=> "Response Received"  } , content_type: 'text/json' }
           else
              format.js { render json: { :successful => false, :notice=> "Something Went Wrong"  } , content_type: 'text/json' }
           end

        end

      end

    end

  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:body, :user_id, :type, answers_attributes:[:body, :question_id])
    end
end
