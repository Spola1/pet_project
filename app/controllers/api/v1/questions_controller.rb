class Api::V1::QuestionsController < Api::V1::ApplicationController
  def show
    question = Question.find(params[:id])

    render(json: question)
  end

  def index
    questions = Question.all

    render(json: questions)
  end

  def create
    question = current_resource_owner.questions.build(question_params)

    if question.save
      render json: question
    else
      render json: { errors: question.errors }
    end
  end

  private

  def question_params
    params.permit(:title, :body)
  end
end