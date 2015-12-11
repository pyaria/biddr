10.times do
  User.create({
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: Faker::Internet.password
    })
end

all_users = User.all

all_users.each do |u|
  5.times do
    u.auctions.create({
      title: Faker::Company.bs,
      details: Faker::Lorem.paragraph,
      ends_on:  Faker::Date.forward(23),
      reserve_price: 11 + rand(1000000)
      })
  end
end
