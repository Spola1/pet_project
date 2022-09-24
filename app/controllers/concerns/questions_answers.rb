module QuestionsAnswers
  extend ActiveSupport::Concern

  included do # n+1 includes(:user)
    def load_question_answers(do_render: false)
      @answer ||= @question.answers.build
      @pagy, @answers = pagy(@question.answers.includes(:user).order(created_at: :desc))
      render('questions/show') if do_render
    end
  end
end
