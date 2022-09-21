class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @pagy, @questions = pagy @tag.questions.includes([:user]).includes([:question_tags])
    .includes([:tags])
  end
end
