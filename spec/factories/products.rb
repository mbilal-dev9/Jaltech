FactoryBot.define do
  factory :product do
    name { Faker::FunnyName.name }
    description { Faker::Company.catch_phrase }
    category { Product.categories.keys.sample }
  end
end
