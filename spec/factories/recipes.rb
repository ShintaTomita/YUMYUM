# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    id { 300 }
    name { 'MyString' }
    food_stuff { 'MyText' }
    advise { 'MyText' }
    main_image { 'MyString' }
    first_process { 'MyString' }
    second_process { 'MyString' }
    third_process { 'MyString' }
    fourth_process { 'MyString' }
    first_image { 'MyString' }
    second_image { 'MyString' }
    third_image { 'MyString' }
    fourth_image { 'MyString' }
    user_id { 1 }
    chef_id { 1 }
    price { 500 }
    genre { '主食' }
  end
end
