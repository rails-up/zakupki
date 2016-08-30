require 'rails_helper'

RSpec.describe DeliveryPaymentType, type: :model do
  context 'validationas' do
    it { should validate_presence_of(:value) }
    it { should validate_presence_of(:description) }
  end
  context 'assosiations' do
    it { should have_many(:purchases) }
  end

  context 'flat_shipping_rate' do
    it 'should be 0.0 if not fixed price value' do
      delivery_payment_type = build :delivery_payment_type,
                                    flat_shipping_rate: 9.99
      delivery_payment_type.save

      expect(delivery_payment_type.flat_shipping_rate).to eq(0.0)
    end

    it 'should be set when fix price type is set' do
      delivery_payment_type = build :delivery_payment_type,
                                    value: 'фикисированная стоимость',
                                    flat_shipping_rate: 9.99
      delivery_payment_type.save

      expect(delivery_payment_type.flat_shipping_rate).to eq(9.99)
    end
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
