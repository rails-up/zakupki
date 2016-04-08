require 'rails_helper'

describe Purchase  do
  it { should belong_to(:group) }
  it { should have_many(:orders) }
  it { should have_many(:comments) }

  it { should validate_presence_of(:name) }
  it { should validate_length_of(:name).is_at_least(10) }

  it 'date should not be in path' do 
    purchase = build :purchase, end_date: 2.days.ago
    expect(purchase.valid?).to be_falsy    
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
