FactoryGirl.define do
  factory :group do
    sequence(:name) { |i| "group name #{i}"}
    description "new group description"
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
