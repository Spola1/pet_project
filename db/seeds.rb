user1 = User.create(email:'alexeihowar50@gmail.com', name:'Alex', nickname:'spola',
  password:'111', password_confirmation:'111', role: 'admin')
user2 = User.create(email:'1@1.ru', name:'Alex', nickname:'vasya',
  password:'111', password_confirmation:'111')
user3 = User.create(email:'admin@admin.com', name:'admin', nickname:'admin',
  password:'admin', password_confirmation:'admin', role: 'admin')

40.times do |n|
  title = "question_title_#{n}"
  body = "question_body_#{n} #question_tag_#{rand(1..5)}"
  Question.create(title: title, body: body, user_id: user3.id, cached_votes_score: rand(2..15))
end