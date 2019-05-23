User.create!(name:  "Le van tri",
 email: "vantri.dev@gmail.com",
 password: "123456",
 password_confirmation: "123456",
 address: "Quang Nam",
 phone: "12345678",
 role: 1,
 activated: true
 )

20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
   email: email,
   password:password,
   password_confirmation: password,
   address: "Quang Nam",
   phone: "12345678",
   role: 0,
   activated: true)
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.create!(name: "Foods", status: 1)
Category.create!(name: "Drinks", status: 1)

25.times do |n|
  category_id = 1
  name = "Foods#{n+1}"
  price = 200
  quantity = 10
  description = "Ngon, bổ, rẻ"
  picture = "https://i.ibb.co/BZtH15r/banhmi.jpg"
  avg_rating = 4.3

  Product.create!(
    category_id: category_id,
    name: name,
    price: price,
    quantity: quantity,
    description: description,
    avg_rating: avg_rating,
    picture: picture
  )
end

25.times do |n|
  category_id = 2
  name = "Drinks#{n+1}"
  price = 333
  quantity = 10
  description = "Ngon, bổ, rẻ"
  picture = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSr00SZ8iUGqQxytSec-jdmILhkUwL36D2aWsrhByx7Qooamf1W"
  avg_rating = 4.3

  Product.create!(
    category_id: category_id,
    name: name,
    price: price,
    quantity: quantity,
    description: description,
    avg_rating: avg_rating,
    picture: picture
  )
end
