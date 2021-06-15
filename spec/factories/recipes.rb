FactoryBot.define do
  factory :recipe do
    name { "MyString" }
    seasoning { "MyText" }
    advise { "MyText" }
    main_image { "MyString" }
    process { "MyString" }
    images { "MyString" }
    user_id { 1 }
    chef_id { 1 }
  end
end
