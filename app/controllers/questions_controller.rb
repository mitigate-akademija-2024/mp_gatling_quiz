class QuestionsController < ApplicationController
  before_action :set_quiz, only: [:new, :create]
  before_action :set_question, only: [:destroy, :edit, :update]
  def index
  end

  def create
    @question = @quiz.questions.new(question_params)

    if params[:commit] == "add_answer"
      @question.answers.new 
      render :new, status: :unprocessable_entity  
    else
      if @question.save
        flash.notice  = "Question created Success!"
        redirect_to quiz_url(@quiz)
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def start
  end

  def new
    @question = @quiz.questions.new
  end

  def edit
  end

  def update

    if params[:commit] == "add_answer"
      @question.answers.new 
      render :edit, status: :unprocessable_entity  
    else
      respond_to do |format|
          if @question.update(question_params)
            format.html { redirect_to question_url(@question), notice: "Question was successfully updated." }
            format.json { render :show, status: :ok, location: @question }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @question.errors, status: :unprocessable_entity }
          end
        end
    end
  end

  def destroy
    @question.destroy!

    redirect_to quiz_path(@question.quiz), notice: "Question was deleted succsessfully!"
  end

  protected

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:question_text, answers_attributes: [:id, :answer_text, :correct, :delete])
  end
end
