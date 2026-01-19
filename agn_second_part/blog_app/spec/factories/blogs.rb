# factory for creating blog test data
FactoryBot.define do
  factory :blog do
    title { Faker::Lorem.sentence(word_count: 3) }
    body { Faker::Lorem.paragraph(sentence_count: 5) }
    published { false }
    association :user

    # trait for published blog
    trait :published do
      published { true }
    end

    # trait for unpublished blog
    trait :unpublished do
      published { false }
    end
  end
end
