class Group < ActiveRecord::Base
  include Sortable
  include ToDropDownMixin
  has_and_belongs_to_many :users
  has_many :purchases, dependent: :destroy
  belongs_to :owner, class_name: 'User', foreign_key: :user_id
  acts_as_commentable

  validates :name, presence: true, uniqueness: true, length: { minimum: 8 }

  scope :enabled, -> { where(enabled: true) }
  scope :by_name, ->(name) { where(name: name) if name }

  def active_purchases_count
    purchases.active.count
  end

  def users_count
    users.count
  end

  def self.all_with_non_exist
    @groups = Group.enabled.all.to_a.map { |s| [s.name, s.id] }
    @groups.unshift([I18n.t('group.non_exist'), 'null'])
    @groups
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
#  enabled     :boolean          default(FALSE)
#  user_id     :integer
#
# Indexes
#
#  index_groups_on_user_id  (user_id)
#
