class CreateDeliveryPaymentTypes < ActiveRecord::Migration
  def self.up
    create_table :delivery_payment_types do |t|
      t.string :value
      t.string :description
    end
    add_reference :purchases, :delivery_payment_type, index: true, foreign_key: true
  end
  def self.down
    drop_table :delivery_payment_types
  end
end
