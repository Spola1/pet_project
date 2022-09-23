class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    # n+1 includes(:user) includes(:question_tags) includes([:tags])
    @pagy, @questions = pagy @tag.questions.includes([:user]).includes([:question_tags])
    .includes([:tags])
  end
end
