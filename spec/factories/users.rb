# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    id { 100 }
    name { 'testuser' }
    email { 'test@example' }
    password { 'testuser' }
  end
end
