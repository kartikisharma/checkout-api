FactoryBot.define do
  factory :item do
    name { Faker::Lorem.word }
    available { true }
  end
end
