class City < ActiveRecord::Base
  has_many :purchases

  validates :name, presence: true, uniqueness: true
end

# == Schema Information
#
# Table name: cities
#
#  id   :integer          not null, primary key
#  name :string
#
