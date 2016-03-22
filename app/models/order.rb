class Order < ActiveRecord::Base
    belongs_to :user
    belongs_to :purchase
    has_many :order_items
end
