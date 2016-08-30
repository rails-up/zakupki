FactoryGirl.define do
  factory :purchase do
    group
    delivery_payment_type
    delivery_payment_cost_type
    city
    owner
    name { Faker::Commerce.product_name }
    catalogue_link { Faker::Internet.url }
    commission 9.9
    address { "#{Faker::Address.city}, #{Faker::Address.street_address}" }
    apartment { Faker::Address.secondary_address }
    description { Faker::Hipster.sentence(3, true, 4) }
    end_date { 5.days.from_now }

    trait :opened do
      status :opened
    end

    factory :opened_purchase do
      status :opened
    end

    factory :funding_purchase do
      status :funding
    end

    factory :distributing_purchase do
      status :distributing
    end

    factory :awaiting_purchase do
      status :awaiting
    end

    factory :closed_purchase do
      status :closed
    end
  end
end

# == Schema Information
#
# Table name: purchases
#
#  id                            :integer          not null, primary key
#  name                          :string
#  description                   :text
#  end_date                      :date
#  status                        :integer
#  group_id                      :integer
#  owner_id                      :integer
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  image_file_name               :string
#  image_content_type            :string
#  image_file_size               :integer
#  image_updated_at              :datetime
#  city_id                       :integer
#  catalogue_link                :string
#  commission                    :float            default(0.0)
#  address                       :string
#  apartment                     :string
#  delivery_payment_type_id      :integer
#  delivery_payment_cost_type_id :integer
#
# Indexes
#
#  index_purchases_on_city_id                        (city_id)
#  index_purchases_on_delivery_payment_cost_type_id  (delivery_payment_cost_type_id)
#  index_purchases_on_delivery_payment_type_id       (delivery_payment_type_id)
#
