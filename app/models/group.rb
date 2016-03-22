class Group < ActiveRecord::Base
    has_many :users
    has_many :purchases
end
