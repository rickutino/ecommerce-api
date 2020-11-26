FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    description { Faker::Lorem.paragraph }
    price { Feker::commerce::Price(range: 5000..9900) }
    # productable { nil }
  end
end
