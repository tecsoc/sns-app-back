FactoryBot.define do
  factory :user do
    email { "MyString" }
    screen_name { "MyString" }
    password { "Password1" }
    password_confirmation { password }
  end
end
