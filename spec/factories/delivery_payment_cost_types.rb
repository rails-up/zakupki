FactoryGirl.define do
  factory :delivery_payment_cost_type do
    value 'test'
    description 'test'
  end
end

# == Schema Information
#
# Table name: delivery_payment_cost_types
#
#  id          :integer          not null, primary key
#  value       :string
#  description :string
#
