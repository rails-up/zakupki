class CreateDeliveryPaymentCostTypes < ActiveRecord::Migration
  def change
    create_table :delivery_payment_cost_types do |t|
      t.string :value
      t.string :description
    end
    add_reference :purchases, :delivery_payment_cost_type, index: true, foreign_key: true
    DeliveryPaymentCostType.reset_column_information
    DeliveryPaymentCostType.create(value: 'по количеству людей', description: 'Общая сумма делится на количество людей')
    DeliveryPaymentCostType.create(value: 'пропорционально стоимости заказа', description: 'Общая сумма делиться пропорционально сумме заказа каждого участника')
    DeliveryPaymentCostType.create(value: 'пропорционально количеству наименований в заказе', description: 'Общая сумма делится пропорционально количеству наименований товаров в заказе')
  end
end
