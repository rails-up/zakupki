class OrderItem < ActiveRecord::Base
    belongs_to :order
end

# == Schema Information
#
# Table name: order_items
#
#  id         :integer          not null, primary key
#  name       :string
#  quantity   :integer
#  cost       :float
#  order_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
