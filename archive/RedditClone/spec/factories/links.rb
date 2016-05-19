# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    title do
      Faker::Name.name
    end
    url do
      Faker::Internet.domain_name
    end
    user_id 1
  end
end
