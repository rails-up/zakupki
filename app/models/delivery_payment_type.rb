class DeliveryPaymentType < ActiveRecord::Base
  has_many :purchases

  validates :value, :description, presence: true

  after_save :flat_shipping_rate_check

  def flat_shipping_rate_check
    self.flat_shipping_rate = 0 if self.value != 'фикисированная стоимость'
  end
end

# == Schema Information
#
# Table name: delivery_payment_types
#
#  id                 :integer          not null, primary key
#  value              :string
#  description        :string
#  flat_shipping_rate :float            default(0.0)
#
