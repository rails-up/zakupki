class City < ActiveRecord::Base
  has_many :purchases
end

# == Schema Information
#
# Table name: cities
#
#  id   :integer          not null, primary key
#  name :string
#
