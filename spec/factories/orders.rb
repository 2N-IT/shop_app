FactoryBot.define do
  factory :order do
    name { 'Client Client' }
    city { 'Baltimore' }
    street { '5th' }
    country { 'Algeria' }
    province { 'Ohio' }
    zip_code { '55-555' }
    payment_method { 'cash' }
    delivery_method { 'ups' }
    status { 'placed' }

    trait :canceled do
      status { 'canceled' }
    end

    trait :paid do
      status { 'paid' }
    end

    trait :processing do
      status { 'processing' }
    end

    trait :in_delivery do
      status { 'in_delivery' }
    end

    trait :completed do
      status { 'completed' }
    end
  end
end
