FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  sequence :nickname do |n|
    "user#{n}"
  end

  sequence :name do |n|
    "name#{n}"
  end

  factory :user do
    email
    password { '12345678' }
    password_confirmation { '12345678' }
    nickname
    name
  end
end
