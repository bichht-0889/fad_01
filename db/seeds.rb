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
end
