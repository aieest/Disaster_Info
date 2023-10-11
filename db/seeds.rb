# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
3.times do |i|
  User.create!(
    email: "#{Faker::Name.first_name.downcase}.#{Faker::Name.last_name.downcase}@gmail.com",
    password: 'password123'
  )
end

50.times do |i|
  post = Post.new
  post.user = User.all.sample
  post.title = Faker::Lorem.sentence
  post.content = Faker::Lorem.paragraph(sentence_count: 4)
  post.address = Faker::Address.full_address
  post.categories << Category.all.sample
  post.save

  10.times do
    post.comments.create(content: Faker::Lorem.paragraph(sentence_count: 4))
  end
end