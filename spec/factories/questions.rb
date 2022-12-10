FactoryBot.define do
  factory :question do
    title {"test#{rand(999)}"}
    body {"test#{rand(999)}"}
    user_id { create(:user).id }
  end
end
