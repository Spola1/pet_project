FactoryBot.define do
  factory :comment do
    body { "comment_#{rand(999)}" }
    user
    commentable factory: :answer || :question
  end
end
