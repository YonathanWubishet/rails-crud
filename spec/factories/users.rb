# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :user do
    id { Faker::Number.digit }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    avatar { Faker::Avatar.image }
  end
end
