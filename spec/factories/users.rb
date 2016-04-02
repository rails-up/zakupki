FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password "11111111"

    factory :user_from_vkontakte do
      email nil
      provider "vkontakte"
      uid 111
    end
  end
end
