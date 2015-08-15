# This will guess the User class
FactoryGirl.define do
  factory :member do
    first_name "John"
    last_name  "Doe"
    password 'password'
    link { "http://www.#{last_name}-industries.com".downcase }
    sequence(:email) { |n| "#{first_name}.#{last_name}-#{n}@example.com".downcase }
    is_admin false
  end

  factory :admin, class: Member do
    first_name "Admin"
    last_name  "User"
    is_admin      true
  end
end
