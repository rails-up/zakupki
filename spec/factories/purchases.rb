FactoryGirl.define do
  factory :purchase do
    name 'Yet another purchase'
    description 'My very new purchase'
    end_date { 5.days.from_now }
    status 1
    group_id 1
  end
end

# == Schema Information
#
# Table name: purchases
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  end_date    :date
#  status      :string
#  group_id    :integer
#  owner_id    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  city_id     :integer
#
# Indexes
#
#  index_purchases_on_city_id  (city_id)
#
