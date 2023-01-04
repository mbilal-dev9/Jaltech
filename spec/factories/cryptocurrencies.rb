FactoryBot.define do
  factory :cryptocurrency do
    name { Faker::CryptoCoin.coin_name }
    code { Faker::CryptoCoin.acronym }
    category { :digital_currency }
  end
end
