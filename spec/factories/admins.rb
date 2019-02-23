# frozen_string_literal: true

FactoryBot.define do
  factory :admin do
    email { 'admin@example.com' }
    password { 'asdasd' }
    password_confirmation { 'asdasd' }
  end
end
