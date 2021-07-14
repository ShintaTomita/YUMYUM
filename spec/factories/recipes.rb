# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    id { 300 }
    name { 'MyString' }
    food_stuff { 'MyText' }
    advise { 'MyText' }
    main_image { "sample.jpg" }
    first_image{ "sample.jpg" }
    second_image { "sample.jpg" }
    third_image { "sample.jpg" }
    fourth_image { "sample.jpg" }
    first_process { 'MyString' }
    second_process { 'MyString' }
    third_process { 'MyString' }
    fourth_process { 'MyString' }
    genre_id { 400 }
    chef_id { 200 }
    to_create { |instance| instance.save(validate: false) }
  end
end
