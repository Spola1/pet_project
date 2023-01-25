class QuestionCreateJob < ApplicationJob
  queue_as :default

  def perform(time)
    sleep(time)
  end
end
