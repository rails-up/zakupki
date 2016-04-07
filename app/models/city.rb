class City < ActiveRecord::Base
  has_many :purchases
end
