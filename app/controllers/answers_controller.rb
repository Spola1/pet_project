class AnswersController < ApplicationController
  include QuestionsAnswers
  include ActionView::RecordIdentifier

  before_action :set_question
  before_action :set_answer, only: [:destroy, :edit, :update]
  before_action :authorize_answer!
  after_action :verify_authorized

  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user

    if @answer.save
      flash[:success] = 'Answer created!'
      redirect_to(question_path(@question))
    else
      load_question_answers(do_render: true)
    end
  end

  def destroy
    @answer.destroy
    flash[:success] = 'Answer deleted!'
    redirect_to(question_path(@question))
  end

  def edit; end

  def update
    if @answer.update(answer_params)
      flash[:success] = 'Answer updated!'
      redirect_to(question_path(@question, anchor: dom_id(@answer)))
    else
      render(:edit)
    end
  end

  def upvote
    @answer = @question.answers.find(params[:id])
    if current_user.voted_up_on?(@answer)
      @answer.unvote_by(current_user)
    else
      @answer.upvote_by(current_user)
    end
    render('answers/vote')
  end

  def downvote
    @answer = @question.answers.find(params[:id])
    if current_user.voted_down_on?(@answer)
      @answer.unvote_by(current_user)
    else
      @answer.downvote_by(current_user)
    end
    render('answers/vote')
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end

  def set_answer
    @answer = @question.answers.find(params[:id])
  end

  def authorize_answer!
    authorize(@answer || Answer)
  end
end
