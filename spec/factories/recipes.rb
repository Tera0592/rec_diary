FactoryBot.define do
  factory :recipe do
    name        { Faker::Food.dish }
    genre_id    { Faker::Number.within(range: 2..4) }
    food        { Faker::Food.ingredient }
    seasoning   { Faker::Food.spice }
    procedure   { Faker::Food.description }

    association :user
    
  end
end
