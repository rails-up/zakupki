class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, join_table: :users_roles

  belongs_to :resource, polymorphic: true

  validates :resource_type, inclusion: { in: Rolify.resource_types }, allow_nil: true

  scopify
end

# == Schema Information
#
# Table name: roles
#
#  id            :integer          not null, primary key
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  resource_id   :integer
#  resource_type :string
#
# Indexes
#
#  index_roles_on_name                                    (name)
#  index_roles_on_name_and_resource_type_and_resource_id  (name,resource_type,resource_id)
#
