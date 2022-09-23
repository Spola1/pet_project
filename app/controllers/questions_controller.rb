class QuestionsController < ApplicationController
  include QuestionsAnswers
  before_action :set_question, only: %i[show destroy edit update]

  def index #n+1 includes(:user) includes(:tags)
    @pagy, @questions = pagy Question.includes(:user).includes(:tags).order(created_at: :desc)
  end

  def show
    load_question_answers
  end

  def destroy
    @question.destroy
    flash[:success] = "Question deleted!"
    redirect_to questions_path
  end

  def edit
  end

  def update
    if @question.update(question_params)
      flash[:success] = "Question updated!"
      redirect_to questions_path
    else
      render :edit
    end
  end

  def new
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = "Question created!"
      redirect_to questions_path
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question
    @question = Question.find_by(id: params[:id])
  end
end
