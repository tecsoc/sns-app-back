FactoryBot.define do
  factory :post do
    content { "テスト用のコンテンツ" }
    user
  end
end