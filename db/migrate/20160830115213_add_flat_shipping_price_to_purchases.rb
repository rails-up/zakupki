class AddFlatShippingPriceToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :flat_shipping_price, :float, default: 0.0
  end
end
