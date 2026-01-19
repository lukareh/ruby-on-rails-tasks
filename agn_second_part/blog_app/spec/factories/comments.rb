# factory for creating comment test data
FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraph(sentence_count: 3) }
    author { Faker::Name.name }
    association :blog, factory: [:blog, :published]
    association :user
  end
end
