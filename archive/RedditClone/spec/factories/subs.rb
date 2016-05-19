# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :sub do
    name Faker::Name.name
    user_id 1
  end
end
