FactoryBot.define do
  factory :investor do
    before(:create) do |investor, _evaluator|
      investor.person = build(:person)
    end
  end
end
