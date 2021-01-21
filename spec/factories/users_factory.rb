FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@test.com" }
    password { SecureRandom.hex(8) }
    admin { false }
  end

  trait :admin do
    admin { true }
  end
end
