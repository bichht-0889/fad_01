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
  email = "example#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
   email: email,
   password:password,
   password_confirmation: password,
   address: "Quang Nam",
   phone: "12345678",
   role: 0,
   activated: true)
end

# Category.create!(name: "Foods", status: 1)
# Category.create!(name: "Drinks", status: 1)

# 25.times do |n|
#   category_id = 1
#   name = "Foods#{n+1}"
#   price = 200
#   quantity = 10
#   description = "Ngon, bổ, rẻ"
#   picture = "https://i.ibb.co/BZtH15r/banhmi.jpg"
#   avg_rating = 4.3

#   Product.create!(
#     category_id: category_id,
#     name: name,
#     price: price,
#     quantity: quantity,
#     description: description,
#     avg_rating: avg_rating,
#     picture: picture
#   )
# end

# 25.times do |n|
#   category_id = 2
#   name = "Drinks#{n+1}"
#   price = 333
#   quantity = 10
#   description = "Ngon, bổ, rẻ"
#   picture = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSr00SZ8iUGqQxytSec-jdmILhkUwL36D2aWsrhByx7Qooamf1W"
#   avg_rating = 4.3

#   Product.create!(
#     category_id: category_id,
#     name: name,
#     price: price,
#     quantity: quantity,
#     description: description,
#     avg_rating: avg_rating,
#     picture: picture
#   )
# end

# 10.times do |n|
#   user_id = 4
#   status = 3
#   total_price = 500

#   Order.create!(
#     user_id: user_id,
#     status: status,
#     total_price: total_price
#   )
# end

# OrderItem.create!(
#   order_id: 3,
#   product_id: 32,
#   price: 30,
#   quantity: 1
# )

# OrderItem.create!(
#   order_id: 4,
#   product_id: 35,
#   price: 30,
#   quantity: 1
# )

# OrderItem.create!(
#   order_id: 5,
#   product_id: 37,
#   price: 30,
#   quantity: 1
# )

# OrderItem.create!(
#   order_id: 6,
#   product_id: 35,
#   price: 30,
#   quantity: 2
# )

# 10.times do |n|
#   product_id = 1
#   user_id = "#{n + 1}"
#   content = "Thom ngon bo re qua troi =)))"
# Comment.create!(
#   product_id: product_id,
#   user_id: user_id,
#   content: content
# )
# end

# 10.times do |n|
#   product_id = 2
#   user_id = "#{n + 1}"
#   content = "Diem 10 chat luong"
# Comment.create!(
#   product_id: product_id,
#   user_id: user_id,
#   content: content
# )
# end

# 10.times do |n|
#   product_id = 3
#   user_id = "#{n + 1}"
#   content = "Good, phuc vu chu dao"
# Comment.create!(
#   product_id: product_id,
#   user_id: user_id,
#   content: content
# )
# end
# OrderItem.create!(
#   order_id: 6,
#   product_id: 35,
#   price: 30,
#   quantity: 2
# )
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.create!(name: "Foods", status: 1)
Category.create!(name: "Drinks", status: 1)

# 25.times do |n|
#   category_id = 1
#   name = "Foods#{n+1}"
#   price = 200
#   quantity = 10
#   description = "Ngon, bổ, rẻ"
#   picture = "https://i.ibb.co/BZtH15r/banhmi.jpg"
#   avg_rating = 4.3

#   Product.create!(
#     category_id: category_id,
#     name: name,
#     price: price,
#     quantity: quantity,
#     description: description,
#     avg_rating: avg_rating,
#     picture: picture
#   )
# end


#   Order.create!(
#     user_id: user_id,
#     status: status,
#     total_price: total_price
#   )
# end

# OrderItem.create!(
#   order_id: 3,
#   product_id: 32,
#   price: 30,
#   quantity: 1
# )

# OrderItem.create!(
#   order_id: 4,
#   product_id: 35,
#   price: 30,
#   quantity: 1
# )

# OrderItem.create!(
#   order_id: 5,
#   product_id: 37,
#   price: 30,
#   quantity: 1
# )

# OrderItem.create!(
#   order_id: 6,
#   product_id: 35,
#   price: 30,
#   quantity: 2
# )
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Category.create!(name: "Foods", status: 1)
# Category.create!(name: "Drinks", status: 1)

# 25.times do |n|
#   category_id = 1
#   name = "Foods#{n+1}"
#   price = 200
#   quantity = 10
#   description = "Ngon, bổ, rẻ"
#   picture = "https://i.ibb.co/BZtH15r/banhmi.jpg"
#   avg_rating = 4.3

#   Product.create!(
#     category_id: category_id,
#     name: name,
#     price: price,
#     quantity: quantity,
#     description: description,
#     avg_rating: avg_rating,
#     picture: picture
#   )
# end

# 25.times do |n|
#   category_id = 2
#   name = "Drinks#{n+1}"
#   price = 333
#   quantity = 10
#   description = "Ngon, bổ, rẻ"
#   picture = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSr00SZ8iUGqQxytSec-jdmILhkUwL36D2aWsrhByx7Qooamf1W"
#   avg_rating = 4.3

#   Product.create!(
#     category_id: category_id,
#     name: name,
#     price: price,
#     quantity: quantity,
#     description: description,
#     avg_rating: avg_rating,
#     picture: picture
#   )
# end
