FactoryGirl.define do

  factory :user do |f|
    f.email {Faker::Internet.email}
    f.screen_name {Faker::Internet.user_name}
    f.password "password"
    f.password_confirmation "password"
  end

  factory :invalid_email do |f|
    f.email nil
  end

end