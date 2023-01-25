class CommentsController < ApplicationController
  include QuestionsAnswers
  before_action :set_commentable
  before_action :set_question
  before_action :authorize_user, only: [:destroy]

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      notify_commentable_author(@commentable, @comment)
      flash[:success] = 'Comment created!'
      redirect_to(question_path(@question))
    else
      @comment = @comment.decorate
      load_question_answers(do_render: true)
    end
  end

  def destroy
    comment = @commentable.comments.find(params[:id])

    comment.destroy
    flash[:success] = 'Comment deleted!'
    redirect_to(question_path(@question))
  end

  private

  def authorize_user
    @comment = Comment.find(params[:id])
    unless current_user.present? && (current_user == @comment.user || current_user.role == 'admin')
      flash[:danger] = 'You are not authorized to perform this action!'
      redirect_to(request.referer || root_path)
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_commentable
    klass = [Question, Answer].detect { |c| params["#{c.name.underscore}_id"] }
    raise ActiveRecord::RecordNotFound if klass.blank?

    @commentable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def set_question
    @question = @commentable.is_a?(Question) ? @commentable : @commentable.question
  end

  def notify_commentable_author(_commentable, comment)
    if comment.commentable_type == 'Question'
      QuestionMailer.commentable(comment).deliver_now unless @commentable.user == comment.user
    else
      AnswerMailer.commentable(comment).deliver_now unless @commentable.user == comment.user
    end
  end
end
