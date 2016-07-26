FactoryGirl.define do
  factory :delivery_payment_type do
    sequence(:value) { |n| "delivery_payment_type value #{n}" }
    sequence(:description) { |n| "delivery_payment_type description #{n}" }
  end
end
