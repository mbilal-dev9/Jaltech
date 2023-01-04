FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "Password1" }
    before(:create) do |user, _evaluator|
      user.profile = create(:investor)
    end
  end
end
