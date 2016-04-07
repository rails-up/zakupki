class Group < ActiveRecord::Base
  include Sortable
  has_and_belongs_to_many :users
  has_many :purchases, dependent: :destroy
  belongs_to :city

  validates :name, presence: true, uniqueness: true, length: { minimum: 8 }

  scope :enabled, -> { where(enabled: true) }
  scope :by_city, ->(city_id) { where(city_id: city_id) if city_id }
end

# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  enabled     :boolean          default("false")
#  city_id     :integer
#
# Indexes
#
#  index_groups_on_city_id  (city_id)
#
