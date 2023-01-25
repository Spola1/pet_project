class QuestionMailer < ApplicationMailer
  def commentable(comment)
    @comment = comment
    @commentable = comment.commentable
    @comment_user = comment.user.name

    mail to: @commentable.user.email, subject: 'Pet project'
  end

  def answer(answer)
    @answer = answer
    @question = answer.question
    @answer_user = answer.user.name

    mail to: @question.user.email, subject: 'Pet project'
  end
end
