FactoryBot.define do
  sequence :title do |n|
    "test#{n}"
  end

  sequence :description do |n|
    "test#{n}"
  end

  factory :todo_list do
    title
    description
    user_id { create(:user).id }
  end
end
