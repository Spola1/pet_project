FactoryBot.define do
  factory :answer do
    body { "answer_#{rand(999)}" }
    question
    user
  end
end
