FactoryGirl.define do
  factory :user do |f|
    f.email_address {Faker::Internet.email}
    f.screen_name {Faker::Internet.user_name}
  end

  factory :invalid_email do |f|
    f.email_address nil
  end

end