FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    screen_name { Faker::Internet.unique.username(specifier: 5..10) }
    handle_name { Faker::Name.name }
    password { "Password1" }
    password_confirmation { password }
  end
end
