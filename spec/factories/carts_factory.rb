FactoryBot.define do
  factory :cart do
    user { create(:user) }
  end

  trait :with_items do
    after(:create) do |cart|
      FactoryBot.create_list(:product_item, 2, cart: cart)
    end
  end
end
