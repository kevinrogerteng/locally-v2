FactoryGirl.define do

  factory :user do |f|
    f.email {Faker::Internet.email}
    f.screen_name {Faker::Internet.user_name}
    f.password "password"
    f.password_confirmation "password"
  end

  factory :trip do |f|
    f.name {Faker::Lorem.word}
    f.destination {Faker::Address.city}
    f.completed false
  end

  factory :activity do |f|
    f.name {Faker::Lorem.word}
    f.description {Faker::Lorem.sentence}
    f.address {Faker::Address.street_name}
    f.phone {Faker::PhoneNumber.phone_number}
  end

end