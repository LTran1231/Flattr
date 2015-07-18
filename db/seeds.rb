# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

200.times do
  User.create(
      username: Faker::Internet.user_name,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      body_type: ['thin', 'medium', 'large'].sample,
      gender: ['male', 'female'].sample,
      # dob: Faker::Time.between(20000.days.ago, 10000.days.ago),
      password: Faker::Internet.password,
      email: Faker::Internet.email)
end

200.times do
  Photo.create(user_id: rand(1..200))
end
