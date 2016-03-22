class Purchase < ActiveRecord::Base
    belongs_to :group
    belongs_to :user, foreign_key: "owner"
    has_many :orders
    has_many :comments
end
