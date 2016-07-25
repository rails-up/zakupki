class CreateDeliveryPaymentCostTypes < ActiveRecord::Migration
  def change
    create_table :delivery_payment_cost_types do |t|
      t.string :value
      t.string :description
    end
    add_reference :purchases, :delivery_payment_cost_type, index: true, foreign_key: true
  end
  def self.down
    drop_table :delivery_payment_cost_types
  end
end
