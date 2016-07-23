require 'rails_helper'

RSpec.describe DeliveryPaymentType, type: :model do
  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:description) }
  it { should have_many(:purchases) }
end

# == Schema Information
#
# Table name: delivery_payment_types
#
#  id          :integer          not null, primary key
#  value       :string
#  description :string
#
