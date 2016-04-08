class Group < ActiveRecord::Base
  include Sortable
  has_and_belongs_to_many :users
  has_many :purchases, dependent: :destroy
  belongs_to :city
  belongs_to :owner, class_name: 'User', foreign_key: :user_id

  validates :name, presence: true, uniqueness: true, length: { minimum: 8 }

  scope :enabled, -> { where(enabled: true) }
  scope :by_city, ->(city_id) { where(city_id: city_id) if city_id }

  def active_purchases_count
    purchases.active.count
  end

  def users_count
    users.count
  end
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
#  user_id     :integer
#
# Indexes
#
#  index_groups_on_city_id  (city_id)
#  index_groups_on_user_id  (user_id)
#
