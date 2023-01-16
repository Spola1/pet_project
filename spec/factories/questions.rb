FactoryBot.define do
  factory :question do
    title { "title_#{rand(999)}" }
    body { "body_#{rand(999)}" }
    user
  end
end
