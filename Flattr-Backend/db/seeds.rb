
200.times do
  User.create(
      username: Faker::Internet.user_name,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      body_type: ['thin', 'medium', 'large'].sample,
      gender: ['male', 'female'].sample,
      age: rand(1..66),
      password: Faker::Internet.password,
      email: Faker::Internet.email,
      uid: "#",
      avatar:"#"
      )
end

200.times do
  Photo.create(user_id: rand(1..200))
end


750.times do
  Vote.create(user_id: rand(1..200), photo_id: rand(1..200), like: [true, false].sample)
end

