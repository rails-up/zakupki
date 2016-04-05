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

    factory :user_with_nine_purchases do
      after(:create) do |user|
        9.times{ create(:purchase, owner_id: user.id) }
      end
    end
  end
end
