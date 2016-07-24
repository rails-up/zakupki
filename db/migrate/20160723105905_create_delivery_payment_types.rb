class CreateDeliveryPaymentTypes < ActiveRecord::Migration
  def self.up
    create_table :delivery_payment_types do |t|
      t.string :value
      t.string :description
    end
    add_reference :purchases, :delivery_payment_type, index: true, foreign_key: true
    DeliveryPaymentType.reset_column_information
    DeliveryPaymentType.create(value: 'зависит от количества заказов', description: 'В данном случае за доставку пользователи платят при получении')
    DeliveryPaymentType.create(value: 'фикисированная стоимость', description: 'В данном случае за доставку пользователи платят сразу')
  end

  def self.down
    drop_table :delivery_payment_types
  end
end
