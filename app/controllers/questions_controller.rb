class QuestionsController < ApplicationController
  include QuestionsAnswers
  before_action :require_authentication, only: [:destroy, :update, :edit]
  before_action :set_question, only: [:show, :destroy, :edit, :update]
  before_action :authorize_question!
  after_action :verify_authorized

  def index # n+1 includes(:user) includes(:tags)
    @pagy, @questions = pagy(Question.includes(:user).includes(:tags).order(cached_votes_score: :desc))
  end

  def show
    load_question_answers
  end

  def destroy
    @question.destroy
    flash[:success] = 'Question deleted!'
    redirect_to(questions_path)
  end

  def edit; end

  def update
    if @question.update(question_params)
      flash[:success] = 'Question updated!'
      redirect_to(question_path(@question))
    else
      render(:edit)
    end
  end

  def new
    @question = current_user.questions.build
  end

  def create
    @question = current_user.questions.build(question_params)

    QuestionCreateJob.perform_later(10)
    
    if @question.save
      flash[:success] = 'Question created!'
      redirect_to(question_path(@question))
    else
      render(:new)
    end
  end

  def upvote
    @question = Question.find(params[:id])
    if current_user.voted_up_on?(@question)
      @question.unvote_by(current_user)
    else
      @question.upvote_by(current_user)
    end
    render('questions/vote')
  end

  def downvote
    @question = Question.find(params[:id])
    if current_user.voted_down_on?(@question)
      @question.unvote_by(current_user)
    else
      @question.downvote_by(current_user)
    end
    render('questions/vote')
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question
    @question = Question.find_by(id: params[:id])
  end

  def authorize_question!
    authorize(@question || Question)
  end
end
