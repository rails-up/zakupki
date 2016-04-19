FactoryGirl.define do
  factory :city do
    sequence(:name) { |i| "City #{i}"}
  end
end
