FactoryBot.define do
  sequence :content do |n|
    "test#{n}"
  end

  factory :todo_item do
    content
    todo_list_id { create(:todo_list).id }
    user
  end
end
