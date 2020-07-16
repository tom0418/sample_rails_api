FactoryBot.define do
  factory :todo do
    title { Faker::Lorem.word }
    created_by { Faker::Number.number(10) }

    trait :with_default_items do
      after(:create) do |todo|
        todo.items.create!(name: "Test Item")
      end
    end
  end
end
