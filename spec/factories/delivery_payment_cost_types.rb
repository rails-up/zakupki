FactoryGirl.define do
  factory :delivery_payment_cost_type do
    sequence(:value) { |n| "delivery_payment_cost_type value #{n}" }
    sequence(:description) { |n| "delivery_payment_cost_type description #{n}" }
  end
end
