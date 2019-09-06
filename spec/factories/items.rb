FactoryBot.define do
  factory :item do
    name { Faker::StarWars.character }
    available { false }
  end
end
