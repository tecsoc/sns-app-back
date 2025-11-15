FactoryBot.define do
  factory :user do
    email { "MyString" }
    screen_name { "MyString" }
    handle_name { "UserA" }
    password { "Password1" }
    password_confirmation { password }
  end
end
