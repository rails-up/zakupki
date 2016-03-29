FactoryGirl.define do
  factory :group do
    sequence(:name) { |i| "group name #{i}"}
    description "new group description"
    association :user
  end
end