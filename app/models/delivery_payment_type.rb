class DeliveryPaymentType < ActiveRecord::Base
  has_many :purchases

  validates :value, :description, presence: true
end
