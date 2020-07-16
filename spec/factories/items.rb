FactoryBot.define do
  factory :item do
    name { "Test User" }
    done { false }
    association :todo
  end
end
