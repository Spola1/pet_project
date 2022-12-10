class Api::V1::QuestionsController < Api::V1::ApplicationController
  def show
    question = Question.find(params[:id])

    respond_with(question, each_serializer: QuestionSerializer)
  end

  def index
    questions = Question.all

    respond_with(questions, each_serializer: QuestionSerializer)
  end
end
