FactoryGirl.define do
  factory :auction do
    association :user, factory: :user
    sequence(:title)              { Faker::Company.bs }
    sequence(:details)        { Faker::Lorem.paragraph}
    sequence(:ends_on)              {Faker::Date.forward(23)}
    sequence(:reserve_price)      { 11 + rand(1000000) }
  end

end
