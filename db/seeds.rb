user1 = User.create(email:'alexeihowar50@gmail.com', name:'Alex', nickname:'spola',
  password:'111', password_confirmation:'111', role: 'admin')
user2 = User.create(email:'1@1.ru', name:'Alex', nickname:'vasya',
  password:'111', password_confirmation:'111')
user3 = User.create(email:'admin@admin.com', name:'admin', nickname:'admin',
  password:'admin', password_confirmation:'admin', role: 'admin')

40.times do
  title = "question_title#{rand(999)}"
  body = "question_body#{rand(999)}"
  Question.create(title: title, body: body, user_id: user1.id)
end

30.times do
  title = Faker::Hipster.word
  Tag.create title: title
end
