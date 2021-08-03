# Faker::Config.locale = 'en'

50.times do |n|
    name = Faker::Games::Pokemon.name
    email = Faker::Internet.email
    password = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 )
end
