FactoryBot.define do
  factory :user do
    name                  { Faker::Name.name }
    sequence(:email)      { |n| "test#{n}@example.com" }
    password              { 'password' }
    password_confirmation { 'password' }
    phone_number          { Faker::PhoneNumber.cell_phone }
    post_code             { Faker::Address.postcode }
    address               { 'sample address' }

    trait :customer do
      user_type { 0 }
    end

    trait :specialist do
      user_type { 1 }
    end

  end
end
