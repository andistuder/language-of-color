# This will guess the User class
FactoryGirl.define do
  factory :member do
    first_name 'John'
    last_name 'Doe'
    password 'password'
    link { "http://www.#{last_name}-industries.com".downcase }
    sequence(:email) { |n| "#{first_name}.#{last_name}-#{n}@example.com".downcase }
    is_admin false

    trait :admin do
      is_admin true
    end
    factory :admin, traits: [:admin]
  end
end
