FactoryBot.define do
  factory :recipe do
    name        { Faker::Food.dish }
    genre_id    { Faker::Number.within(range: 2..4) }
    food        { Faker::Food.ingredient }
    seasoning   { Faker::Food.spice }
    procedure   { Faker::Food.description }

    after(:build) do |recipe|
      recipe.image.attach(io: File.open('spec/fixtures/recipe_test_image.jpg'), filename: 'recipe_test_image.jpg', content_type: 'image/jpg')
    end

    association :user
    
  end
end
