FactoryBot.define do
  factory :contact do
    trait :lyanna do
      name { 'L&ana Stark' }
      date_of_birth { '19220230' }
      phone { '123456778' }
      address { 'Winterfell' }
      credit_card { 'las8sd7zal10238d' }
      franchise { 'American Express' }
      email { 'lyanna.starkwesteros.com' }
      card_last4 { '8431' }
    end
    trait :aerys do
      name { 'Aerys Targaryen' }
      date_of_birth { '19010222' }
      phone { '888' }
      address { "King's Landing" }
      credit_card { '19283hdna&ks' }
      franchise { "Diner's Club" }
      email { 'aerys_madking@westeros.com' }
      card_last4 { '5904' }
    end
    trait :elia do
      name { 'Elia Martell' }
      date_of_birth { '19200202' }
      phone { '' }
      address { 'Dorne' }
      credit_card { 'pa0s8d7jzmakld!' }
      franchise { 'Mastercard' }
      email { 'elia.martell@westeros.com' }
      card_last4 { '4444' }
    end
    trait :robert do
      name { '' }
      date_of_birth { '' }
      phone { '' }
      address { '' }
      credit_card { '' }
      franchise { '' }
      email { '' }
      card_last4 { '' }
    end
  end
end