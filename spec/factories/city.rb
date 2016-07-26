FactoryGirl.define do
  sequence :name do |n|
    "City #{n}"
  end

  factory :city do
    name
  end
end
