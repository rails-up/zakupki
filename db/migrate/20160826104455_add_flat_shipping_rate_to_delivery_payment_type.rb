class AddFlatShippingRateToDeliveryPaymentType < ActiveRecord::Migration
  def change
    add_column :delivery_payment_types, :flat_shipping_rate, :float, default: 0.0
  end
end
