FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "ProductCool#{n}" }
    price { rand(42.24) }
    quantity { rand(5..100) }
  end
end
