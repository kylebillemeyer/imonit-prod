FactoryGirl.define do
  factory :user do
    email
    first "kyle"
    last "billemeyer"
  end

  sequence :email do |n|
    "kyle#{n}@example.com"
  end

  factory :group do
    name "Test Group"
    desc "A group used for testing."
  end

  factory :item do 
    name "Test Item"
    desc "An item used for testing"
  end

  factory :tracking do
    measurement :cm
    threshold 4
    remaining 10
  end

  factory :tracking_subscription do
  end
end