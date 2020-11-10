FactoryBot.define do
  factory :diary do
    time        { Faker::Date.forward }
    title       { Faker::Lorem.word }
    impression  { Faker::Lorem.sentences }

    after(:build) do |diary|
      diary.image.attach(io: File.open('spec/fixtures/diary/diary_test_image.jpg'), filename: 'diary_test_image.jpg', content_type: 'image/jpg')
    end

    association :user

  end
end
