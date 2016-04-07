class Order < ActiveRecord::Base
    belongs_to :user
    belongs_to :purchase
    has_many :order_items
end

# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  status      :string
#  purchase_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
