FactoryBot.define do
  factory :product_item do
    product { create(:product) }
    name { product.name }
    price { product.price }
    quantity { rand(1..5) }
  end
end
