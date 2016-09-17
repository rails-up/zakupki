FactoryGirl.define do
  factory :group do
    sequence(:name) { |i| "group name #{i}"}
    description { Faker::Hipster.sentence(5, true, 5) }
    trait :enabled do
      enabled true
    end
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
