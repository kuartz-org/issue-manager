FactoryBot.define do
  factory :user do
    password    { 'password' }

    sequence(:email) { |index| "user#{index}@example.com" }
  end
end
