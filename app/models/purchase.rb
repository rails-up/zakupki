class Purchase < ActiveRecord::Base
    belongs_to :group
    belongs_to :user, foreign_key: "owner"
    has_many :orders, dependent: :destroy
    has_many :comments, dependent: :destroy
end
