FactoryBot.define do
  factory :user do
    trait :rhaegar do
      email { 'rhaegar@westeros.com' }
      password { '123456' }
    end
  end
end