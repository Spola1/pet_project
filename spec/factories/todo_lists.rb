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
    user
  

    factory :todo_list_with_todo_items do
      transient do
        todo_items_count { 3 }
      end

      after(:create) do |todo_list, evaluator|
        create_list(:todo_item, evaluator.todo_items_count, todo_list: todo_list)
      end
    end
  end
end
