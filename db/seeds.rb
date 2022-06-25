5.times do
  Post.create(title: Faker::Movie.title, body: Faker::Movie.quote)
end
