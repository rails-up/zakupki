FactoryGirl.define do
  factory :purchase do
    name 'Yet another purchase'
    description 'My very new purchase'
    end_date { 5.days.from_now }
    status 1
    group_id 1
  end
end
