5.times do |n|
  User.create(email:"#{n}@#{n}.com", name:"#{n}", nickname:"#{n}",
    password:'111', password_confirmation:'111')
end

admin = User.create(email:'admin@admin.com', name:'admin', nickname:'admin',
  password:'admin', password_confirmation:'admin', role: 'admin')

40.times do
  title = Faker::Hipster.word
  body = "#{Faker::Lorem.paragraph(sentence_count: 5, supplemental: true, random_sentences_to_add: 4)} 
    ##{Faker::Hipster.word} ##{Faker::Hipster.word}"
  question = Question.create(title: title, body: body, user_id: admin.id)
end

30.times do
  title = Faker::Hipster.word
  Tag.create title: title
end
