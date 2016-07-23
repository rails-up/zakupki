class DeliveryPaymentType < ActiveRecord::Base
  has_many :purchases

  validates :value, :description, presence: true
end

# == Schema Information
#
# Table name: delivery_payment_types
#
#  id          :integer          not null, primary key
#  value       :string
#  description :string
#
