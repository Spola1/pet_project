user = User.create(email:'alexeihowar50@gmail.com', name:'Alex', nickname:'spola', password:'111', password_confirmation:'111')

40.times do
  title = Faker::Hipster.sentence(word_count: 3)
  body = Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 4)
  Question.create(title: title, body: body, user_id: user.id)
end
