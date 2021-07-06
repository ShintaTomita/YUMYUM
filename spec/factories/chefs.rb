# frozen_string_literal: true

FactoryBot.define do
  factory :chef do
    id { 200 }
    name { 'MyString' }
    email { 'testchef@example.com' }
    password { 'testchef' }
    password_confirmation { 'testchef' }
  end
end
