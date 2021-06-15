FactoryBot.define do
  factory :chef do
    id { 200 }
    name { "MyString" }
    image { "MyString" }
    email { "testchef@example.com"}
    password { "testchef"}
    password_confirmation { "testchef" }
    shop_name { "MyString" }
    shop_url { "#" }
    shop_tel { 1 }
    introduction { "MyText" }
  end
end
