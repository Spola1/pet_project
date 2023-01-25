class AnswerMailer < ApplicationMailer
  def commentable(comment)
    @comment = comment
    @commentable = comment.commentable
    @comment_user = comment.user.name

    mail to: @commentable.user.email, subject: 'Pet project'
  end
end
