FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password "11111111"
    username "Test User"
    phone "123-123-123"

    factory :user_from_vkontakte do
      email nil
      provider "vkontakte"
      uid 111
    end
  end
end
