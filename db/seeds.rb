User.create!(name:  "Le van tri",
 email: "vantri.dev@gmail.com",
 password: "123456",
 password_confirmation: "123456",
 address: "Quang Nam",
 phone: "12345678",
 role: 1,
 activated: true
 )

User.create!(name:  "Hoang Bich",
 email: "hbich95@gmail.com",
 password: "123456",
 password_confirmation: "123456",
 address: "Quang Nam",
 phone: "12345678",
 role: 1,
 activated: true
 )

 User.create!(name:  "Thuong Dan",
 email: "hbich@gmail.com",
 password: "123456",
 password_confirmation: "123456",
 address: "Quang Nam",
 phone: "12345678",
 role: 0,
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

Category.create!(name: "Foods", status: 1)
Category.create!(name: "Drinks", status: 1)

25.times do |n|
  category_id = 1
  name = "Foods#{n+1}"
  price = Faker::Number.between(10, 100)
  quantity = Faker::Number.between(1, 15)
  description = Faker::Lorem.sentence
  picture = nil
  avg_rating = 0
end

25.times do |n|
  category_id = 2
  name = "Drinks#{n+1}"
  price = Faker::Number.between(10, 100)
  quantity = Faker::Number.between(1, 15)
  description = Faker::Lorem.sentence
  picture = nil
  avg_rating = 0

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

10.times do |n|
  user_id = 4
  status = 3
  total_price = 500

  Order.create!(
    user_id: user_id,
    status: status,
    total_price: total_price
  )
end

OrderItem.create!(
  order_id: 3,
  product_id: 32,
  price: 30,
  quantity: 1
)

OrderItem.create!(
  order_id: 4,
  product_id: 35,
  price: 30,
  quantity: 1
)

OrderItem.create!(
  order_id: 5,
  product_id: 37,
  price: 30,
  quantity: 1
)

OrderItem.create!(
  order_id: 6,
  product_id: 35,
  price: 30,
  quantity: 2
)

10.times do |n|
  product_id = 1
  user_id = "#{n + 1}"
  content = Faker::Lorem.sentence
Comment.create!(
  product_id: product_id,
  user_id: user_id,
  content: content
)
end

10.times do |n|
  product_id = 2
  user_id = "#{n + 1}"
  content = Faker::Lorem.sentence
Comment.create!(
  product_id: product_id,
  user_id: user_id,
  content: content
)
end

10.times do |n|
  product_id = 3
  user_id = "#{n + 1}"
  content = Faker::Lorem.sentence
Comment.create!(
  product_id: product_id,
  user_id: user_id,
  content: content
)
end

40.times do |n|
  user_id = Random.rand(10) + 1
  category_id = Random.rand(2) + 1
  name = Faker::Name.name
  description = Faker::Lorem.sentence
  status = Random.rand(4)
  status == 1 ? new_category = Faker::Name.name : nil
Sugest.create!(
  user_id: user_id,
  category_id: category_id,
  name: name,
  description: description,
  status: status,
  new_category: new_category
)
end
