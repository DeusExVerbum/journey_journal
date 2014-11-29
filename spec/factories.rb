FactoryGirl.define do
  sequence :email do |n|
    "test#{n}@example.com"
  end 

  factory :user do
    email
    password "12345678"
  end

  factory :journey do
    user
    title "My Time In France"
    description "A wonderful journey."
  end

  factory :entry_no_journey do
    user
    title "Taj Mahal!"
    body "The bestest thing!"
  end

  factory :entry do
    user
    journey
    title "The Eiffel Tower"
    body "The tallest thing!"
    longitude 1.0
    latitude 1.0
  end
end

def build_attributes(*args)
  FactoryGirl.build(*args).attributes.delete_if do |k, v|
    ["id", "created_at", "updated_at"].member?(k)
  end
end
