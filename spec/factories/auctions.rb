FactoryGirl.define do
  factory :auction do
    association :user, factory: :user
    sequence(:title)              { Faker::Company.bs }
    sequence(:description)        { Faker::Lorem.paragraph}
    end_date                      60.days.from_now
    sequence(:reserve_price)      { 11 + rand(1000000) }
  end

end
