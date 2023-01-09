FactoryBot.define do
  factory :tag do
    title { "#tag#{rand(999)}" }
  end
end
