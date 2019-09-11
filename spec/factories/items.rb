FactoryBot.define do
  factory :item do
    name { Faker::Lorem.word }
    barcode { Faker::IDNumber.south_african_id_number }
    available { true }
  end
end
